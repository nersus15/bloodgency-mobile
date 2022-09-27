import 'package:bloodgency/utils/utils.dart';
import 'package:bloodgency/values/CustomColors.dart';
import 'package:bloodgency/values/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

typedef VoidCallbackString = void Function(String string);

class CustomTextEditing extends StatelessWidget {
  const CustomTextEditing({
    Key? key,
    TextEditingController? this.controller,
    Widget? this.prefixIcon,
    Widget? this.suffixIcon,
    Color this.color = white,
    Color? this.shadow,
    InputBorder this.border = InputBorder.none,
    String? this.hint,
    TextInputType? this.type,
    bool this.show = true,
    bool this.enabled = true,
    VoidCallbackString? this.onChange,
    VoidCallback? this.onTap,
    bool this.dropdown = false,
    int this.line = 1,
    List<DropdownMenuItem<String>>? this.options,
  }) : super(key: key);

  final TextEditingController? controller;
  final Widget? prefixIcon, suffixIcon;
  final InputBorder border;
  final Color color;
  final Color? shadow;
  final String? hint;
  final TextInputType? type;
  final bool show, enabled, dropdown;
  final VoidCallback? onTap;
  final VoidCallbackString? onChange;
  final List<DropdownMenuItem<String>>? options;
  final int line;

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: shadow,
      elevation: 3,
      borderRadius: BorderRadius.circular(10),
      child: dropdown
          ? DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                prefixIcon: prefixIcon,
                suffix: suffixIcon,
                fillColor: color,
                focusColor: color,
              ),
              hint: Text(
                hint!,
                style: TextStyle(color: subText),
              ),
              items: options,
              onChanged: (String? val) {
                if (onChange != null) onChange!(val!);
              },
            )
          : TextField(
              maxLines: line,
              onTap: () {
                if (onTap != null) onTap!();
              },
              onChanged: (value) {
                if (onChange != null) onChange!(value);
              },
              keyboardType: type,
              enabled: enabled,
              obscureText: !show,
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                hintStyle: TextStyle(color: subText),
                hintText: hint,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                fillColor: color,
                focusColor: color,
                border: border,
              ),
            ),
    );
  }
}
