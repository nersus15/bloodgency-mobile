import 'package:bloodgency/values/CustomColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    this.show = true,
    Widget? this.action,
  }) : super(key: key);
  final String title;
  final bool show;
  final Widget? action;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: show ? 70 : 0,
      duration: Duration(microseconds: 200),
      child: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        elevation: 0,
        leadingWidth: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Color.fromARGB(143, 213, 212, 238),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(left: 0, top: 20),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 50,
            ),
            Text(
              title,
              style: TextStyle(
                color: text,
                fontFamily: "Poppins-SemiBold",
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 50,
            ),
            if (action != null) action!
          ],
        ),
        backgroundColor: white,
      ),
    );
  }
}
