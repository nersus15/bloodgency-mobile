import 'dart:convert';

import 'package:bloodgency/providers/request_provider.dart';
import 'package:bloodgency/screens/home_screen.dart';
import 'package:bloodgency/screens/onboarding_screen.dart';
import 'package:bloodgency/utils/utils.dart';
import 'package:bloodgency/values/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bloodgency/values/CustomColors.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool isLogin = false;
  Map<String, String> headers = {};
  String? token;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Utils.isLogin(context).then((value) {
      setState(() {
        isLogin = value['isLogin'];
        token = value['token'];
        if (value['isLogin']) {
          headers['Authorization'] = 'Bearer ${token}';
        }
      });
      Utils.internet.fetch(
        context: context,
        url: Endpoint['request_lists'],
        headers: headers,
        onError: (response) async {
          Map<String, dynamic> body = await jsonDecode(response!.body);
          print(body);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const OnBoardingScreen(),
            ),
          );
        },
        onSuccess: (response) async {
          Map<String, dynamic> body = await jsonDecode(response!.body);
          final requestProvider =
              Provider.of<BloodRequestProvider>(context, listen: false);
          requestProvider.setRequest(body['data']);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => isLogin ? HomeScreen() : OnBoardingScreen(),
            ),
          );
        },
        onNoInternet: () {},
      );
    });
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
