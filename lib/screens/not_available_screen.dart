import 'package:bloodgency/components/appbar.dart';
import 'package:bloodgency/values/CustomColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NotAvailableScreen extends StatelessWidget {
  const NotAvailableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
          child: Column(
        children: [
          CustomAppBar(title: "Not Available"),
          Expanded(
            child: Column(
              children: [
                Image(
                  image: AssetImage("assets/images/features/404.jpg"),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
