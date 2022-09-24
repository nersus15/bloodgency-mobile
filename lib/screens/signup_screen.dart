import 'package:bloodgency/components/button_component.dart';
import 'package:bloodgency/screens/login_screen.dart';
import 'package:bloodgency/values/CustomColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _phone = TextEditingController();
  String _blood = 'A+';
  TextEditingController _address = TextEditingController();

  bool isShow = false;
  List<String> blood_category = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 200,
        flexibleSpace: Center(
          child: Image(
            image: AssetImage("assets/images/splash_logo.png"),
            color: primary,
            height: 150,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _username,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(
                      Icons.person,
                      color: primary,
                    ),
                    hintText: "Fullname",
                    fillColor: textField,
                    focusColor: textField,
                    border: InputBorder.none),
              ),
              SizedBox(
                height: 10,
              ),
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
                height: 10,
              ),
              TextField(
                controller: _phone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(
                      Icons.phone,
                      color: primary,
                    ),
                    hintText: "Phone Number",
                    fillColor: textField,
                    focusColor: textField,
                    border: InputBorder.none),
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  prefixIcon: Icon(
                    Icons.bloodtype,
                    color: primary,
                  ),
                  fillColor: textField,
                  focusColor: textField,
                ),
                hint: Text('Please choose your blood category'),
                items: blood_category.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (String? val) {
                  setState(() {
                    _blood = val!;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _address,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(
                      Icons.person_pin_circle_outlined,
                      color: primary,
                    ),
                    hintText: "Address",
                    fillColor: textField,
                    focusColor: textField,
                    border: InputBorder.none),
              ),
              SizedBox(
                height: 40,
              ),
              PrimaryButton(text: "REGISTER", onTap: () {}),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(color: subText),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: Text(
                      "Log In",
                      style: TextStyle(color: primary),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
