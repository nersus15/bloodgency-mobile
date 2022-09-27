import 'dart:convert';

import 'package:bloodgency/screens/onboarding_screen.dart';
import 'package:bloodgency/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bloodgency/values/CustomColors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Utils.internet.fetch(
      context: context,
      url: "https://ta.kamscode.site/futsal/ws/logout",
      onError: (response) async {
        Map<String, dynamic> body = await jsonDecode(response!.body);
        print(body['message']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OnBoardingScreen(),
          ),
        );
      },
      onSuccess: (response) async {
        List<dynamic> body = await jsonDecode(response!.body);
        print(body);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OnBoardingScreen(),
          ),
        );
      },
      onNoInternet: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isWaiting = false;

    return Container(
      color: primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Spacer(),
          Image(image: AssetImage("assets/images/splash_logo.png")),
          Image(image: AssetImage("assets/images/splash_footer.png")),
        ],
      ),
    );
  }
}
