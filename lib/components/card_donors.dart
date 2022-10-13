import 'package:bloodgency/values/CustomColors.dart';
import 'package:bloodgency/values/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DonorCard extends StatelessWidget {
  const DonorCard({
    required this.nama,
    required this.lokasi,
    required this.darah,
    String? this.image,
    BorderRadius? this.borderRadius,
    EdgeInsetsGeometry? this.margin,
    VoidCallback? this.onTap,
    VoidCallback? this.onLongPress,
    Key? key,
  }) : super(key: key);
  final String nama, lokasi, darah;
  final String? image;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap, onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap!();
      },
      onLongPress: () {
        if (onLongPress != null) onLongPress!();
      },
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          color: white,
          boxShadow: boxShadow['bold'],
          borderRadius: borderRadius,
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (image != null)
              Flexible(
                child: ClipRRect(
                  child: Image(
                    width: 80,
                    height: 80,
                    image: NetworkImage(image!),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  nama,
                  style: TextStyle(
                      color: text,
                      fontSize: 18,
                      fontFamily: "Poppins-SemiBold"),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.pin_drop,
                      color: primary,
                    ),
                    Text(
                      lokasi,
                      style: TextStyle(
                          color: subText,
                          fontSize: 14,
                          fontFamily: "Poppins-Medium"),
                    ),
                  ],
                )
              ],
            ),
            Image(
              image: AssetImage(
                  "assets/images/blood category/${darah.toUpperCase()}.png"),
              width: 38,
              height: 55,
            ),
          ],
        ),
      ),
    );
  }
}
