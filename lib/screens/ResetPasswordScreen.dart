import 'dart:async';

import 'package:bloodgency/components/button_component.dart';
import 'package:bloodgency/values/CustomColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bloodgency/utils/utils.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController _email = TextEditingController();
  bool canSend = true;

  String errorText = "";

  late Timer _timer;
  int _start = 60;
  void startTimer() {
    const onSec = const Duration(seconds: 1);
    _timer = Timer.periodic(onSec, (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
          canSend = true;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    if (!canSend) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        color: white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.mail,
                        color: primary,
                      ),
                      errorText: errorText,
                      hintText: "Email",
                      fillColor: textField,
                      focusColor: textField,
                      border: InputBorder.none),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  !canSend ? "Resend in ${_start} Second." : "",
                  style: TextStyle(color: primary),
                )
              ],
            ),
            const Text(
              "Your password reset will be send in your registered email address.",
              style: TextStyle(color: subText),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            PrimaryButton(
                text: "Send",
                onTap: () {
                  if (_email.value.text.isEmpty) {
                    setState(() {
                      errorText = "Alamat email harus diisi.";
                    });
                    return;
                  } else if (!Utils.isValidEmail(_email.value.text)) {
                    setState(() {
                      errorText = "Alamat email tidak valid";
                    });
                    return;
                  }
                  if (!canSend)
                    return;
                  else {
                    setState(() {
                      errorText = '';
                    });
                    print("Send");
                    setState(() {
                      canSend = false;
                    });
                    startTimer();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
