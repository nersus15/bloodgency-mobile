import 'dart:async';

import 'package:bloodgency/components/button_component.dart';
import 'package:bloodgency/values/CustomColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen(
      {Key? key, this.emailAddress = "fathur.ashter15@gmail.com"})
      : super(key: key);
  final String emailAddress;
  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  String currentText = "";
  final formKey = GlobalKey<FormState>();
  bool canSend = true;
  bool resend = true;

  String errorText = "";

  late Timer _timer;
  int _start = 60;
  void startTimer() {
    _start = 60;
    setState(() {
      resend = true;
    });
    const onSec = const Duration(seconds: 1);
    _timer = Timer.periodic(onSec, (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
          resend = false;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    _timer.cancel();
    super.dispose();
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Form(
                  key: formKey,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 6,
                      obscureText: false,
                      onChanged: (value) {
                        if (value.length == 6) {
                          setState(() {
                            canSend = true;
                          });
                        } else {
                          setState(() {
                            canSend = false;
                          });
                        }
                      },
                      cursorColor: primary,
                      controller: textEditingController,
                      animationDuration: const Duration(milliseconds: 300),
                      errorAnimationController: errorController,
                      animationType: AnimationType.fade,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: textField,
                          blurRadius: 1,
                        )
                      ],
                    ),
                  ),
                ),
                resend
                    ? Text(
                        "Resend in ${_start} Second.",
                        style: TextStyle(color: primary),
                      )
                    : TextButton(
                        onPressed: startTimer,
                        child: Text(
                          "Resend",
                          style: TextStyle(color: primary),
                        ))
              ],
            ),
            SizedBox(
              height: 50,
            ),
            PrimaryButton(
              enable: canSend,
              text: "Verifikasi",
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
