import 'package:bloodgency/models/navitationitem_model.dart';
import 'package:bloodgency/values/CustomColors.dart';
import 'package:bloodgency/values/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({Key? key, required this.currentNavigation})
      : super(key: key);
  final int currentNavigation;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: white,
        boxShadow: boxShadow['bold'],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: NavigationItemModel.item(context, currentNavigation),
      ),
    );
  }
}
