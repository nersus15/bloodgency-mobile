import 'package:flutter/cupertino.dart';

typedef VoidCallbackContext = void Function(BuildContext context);

class FeaturesModel {
  FeaturesModel({required this.image, required this.onTap, this.label = ""});
  final String image;
  final String label;
  final VoidCallbackContext onTap;
}
