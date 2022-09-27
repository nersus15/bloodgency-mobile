import 'package:bloodgency/components/button_component.dart';
import 'package:bloodgency/screens/home_screen.dart';
import 'package:bloodgency/screens/reset_password_screen.dart';
import 'package:bloodgency/screens/signup_screen.dart';
import 'package:bloodgency/values/CustomColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:onboarding/onboarding.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool isShow = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    }),
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
