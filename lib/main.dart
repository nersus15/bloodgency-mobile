import 'dart:convert';

import 'package:bloodgency/models/request_model.dart';
import 'package:bloodgency/providers/request_provider.dart';
import 'package:bloodgency/screens/login_screen.dart';
import 'package:bloodgency/screens/splash_screen.dart';
import 'package:bloodgency/utils/utils.dart';
import 'package:bloodgency/values/CustomColors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:web_socket_channel/web_socket_channel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BloodRequestProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Bloodgency',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
