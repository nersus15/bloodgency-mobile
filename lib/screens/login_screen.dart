import 'dart:convert';

import 'package:bloodgency/components/button_component.dart';
import 'package:bloodgency/screens/home_screen.dart';
import 'package:bloodgency/screens/reset_password_screen.dart';
import 'package:bloodgency/screens/signup_screen.dart';
import 'package:bloodgency/utils/utils.dart';
import 'package:bloodgency/values/CustomColors.dart';
import 'package:bloodgency/values/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:localstore/localstore.dart';
import 'package:onboarding/onboarding.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  String _emailError = '';
  String _passwordError = '';
  bool isShow = false;
  final localStorage = Localstore.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void Login() {
    Utils.internet.fetch(
      method: 'POST',
      context: context,
      body: {'email': _email.value.text, 'password': _password.value.text},
      url: Endpoint['login'],
      onSuccess: (response) async {
        Map<String, dynamic> body = await jsonDecode(response!.body);
        localStorage
            .collection('auth')
            .doc('token')
            .set({'token': body['token']});

        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => HomeScreen(),
        //   ),
        // );
      },
      onError: (response) async {
        Map<String, dynamic> body = await jsonDecode(response!.body);
        print(body['message']);
        if (body['message'] ==
            'User with email address ${_email.value.text} not found') {
          setState(() {
            _emailError = "User Tidak ditemukan";
            _passwordError = '';
          });
        } else if (body['message'] ==
            'Gagal Login, Password untuk user ${_email.value.text} salah.') {
          setState(() {
            _passwordError = 'Gagal Login, Password salah.';
            _emailError = '';
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 35),
        color: white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              image: AssetImage('assets/images/splash_logo.png'),
              color: primary,
              width: 200,
            ),
            Column(
              children: [
                TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Icon(
                        Icons.mail,
                        color: primary,
                      ),
                      hintText: "Email",
                      errorText: _emailError,
                      fillColor: textField,
                      focusColor: textField,
                      border: InputBorder.none),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _password,
                  obscureText: !isShow,
                  decoration: InputDecoration(
                      filled: true,
                      errorText: _passwordError,
                      hintText: "Password",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: primary,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isShow = !isShow;
                          });
                        },
                        icon: Icon(
                          isShow ? Icons.visibility_off : Icons.visibility,
                          color: primary,
                        ),
                      ),
                      fillColor: textField,
                      focusColor: textField,
                      border: InputBorder.none),
                ),
                SizedBox(
                  height: 50,
                ),
                PrimaryButton(
                  text: "LOG IN",
                  onTap: Login,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ResetPasswordScreen()),
                    );
                  },
                  child: Text(
                    "Forgot Passwotrd?",
                    style: TextStyle(color: primary),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: TextStyle(color: subText),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()),
                    );
                  },
                  child: Text(
                    'Register Now.',
                    style: TextStyle(color: primary),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
