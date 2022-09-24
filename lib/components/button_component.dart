import 'dart:ffi';

import 'package:bloodgency/values/CustomColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.enable = true,
    this.onLongpress,
    this.onDoubleTap,
  }) : super(key: key);

  final bool enable;
  final GestureLongPressCallback? onLongpress;
  final GestureDoubleTapCallback? onDoubleTap;
  final String text;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongpress,
      onDoubleTap: onDoubleTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: enable ? primary : primary.withOpacity(0.3),
        ),
        child: Text(
          text,
          style: const TextStyle(color: white),
        ),
      ),
    );
  }
}
