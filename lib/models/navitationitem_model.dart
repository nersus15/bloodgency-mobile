import 'package:bloodgency/screens/donation_screen.dart';
import 'package:bloodgency/screens/home_screen.dart';
import 'package:bloodgency/values/CustomColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationItemModel {
  NavigationItemModel({
    required this.icon,
    required this.onTap,
    this.type = '',
    this.label = '',
  });
  final IconData icon;
  final String type, label;
  final VoidCallback onTap;

  static List<Widget> item(BuildContext context, active) {
    List<NavigationItemModel> items = [
      NavigationItemModel(
          icon: Icons.home,
          onTap: () {
            if (active == 0) return;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }),
      NavigationItemModel(
          icon: Icons.search,
          onTap: () {
            if (active == 1) return;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }),
      NavigationItemModel(
          icon: Icons.stacked_line_chart,
          onTap: () {
            if (active == 2) return;
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const DonationRequestScreen()),
            );
          }),
      NavigationItemModel(
          icon: Icons.person,
          onTap: () {
            if (active == 3) return;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }),
    ];

    List<Widget> navItems = [];
    int spacer = (items.length / 2).round();
    items.asMap().forEach((int index, NavigationItemModel item) {
      List<Widget> tmp = [
        Icon(
          item.icon,
          color: index == active ? primary : subText,
        )
      ];
      if (item.label != "") {
        tmp.add(Text(item.label));
      }

      if (index == active) {
        tmp.add(Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(color: primary, shape: BoxShape.circle),
        ));
      }
      if (index == spacer) {
        navItems.add(SizedBox(
          width: 50,
        ));
      }
      navItems.add(
        GestureDetector(
          onTap: () {
            item.onTap();
          },
          child: Column(
            children: tmp,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
      );
    });
    return navItems;
  }
}
