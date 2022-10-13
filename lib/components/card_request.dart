import 'package:bloodgency/values/CustomColors.dart';
import 'package:bloodgency/values/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DonorRequestCard extends StatelessWidget {
  const DonorRequestCard({
    required this.pasien,
    required this.lokasi,
    required this.darah,
    required this.waktu,
    required this.terkumpul,
    required this.total,
    BorderRadius? this.borderRadius,
    EdgeInsetsGeometry? this.margin,
    Key? key,
  }) : super(key: key);
  final String pasien, lokasi, darah, waktu;
  final int terkumpul, total;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nama Pasien",
                style: TextStyle(
                  fontSize: 14,
                  color: subText,
                  fontFamily: 'Poppins-Regular',
                ),
              ),
              SizedBox(height: 7),
              Text(
                pasien,
                style: TextStyle(
                  fontSize: 14,
                  color: text,
                  fontFamily: 'Poppins-Medium',
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Lokasi",
                style: TextStyle(
                  fontSize: 14,
                  color: subText,
                  fontFamily: 'Poppins-Regular',
                ),
              ),
              SizedBox(height: 7),
              Text(
                lokasi,
                style: TextStyle(
                  fontSize: 14,
                  color: text,
                  fontFamily: 'Poppins-Medium',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                waktu,
                style: TextStyle(
                  color: subText,
                  fontFamily: 'Poppins-Medium',
                  fontSize: 12,
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image(
                image: AssetImage(
                    "assets/images/blood category/${darah.toUpperCase()}.png"),
                width: 38,
                height: 55,
              ),
              Container(
                  width: 50,
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Text(
                        "$terkumpul/$total",
                        style: TextStyle(
                          color: subText,
                          fontFamily: "Poppins-Medium",
                        ),
                      ),
                      LinearProgressIndicator(
                        minHeight: 5,
                        color: primary,
                        backgroundColor: primary.withAlpha(50),
                        value: terkumpul / total,
                        semanticsLabel: 'Linear progress indicator',
                      ),
                    ],
                  )),
              GestureDetector(
                onTap: () {
                  print("Donate");
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Donor",
                    style: TextStyle(
                      color: primary,
                      fontFamily: 'Poppins-Medium',
                      fontSize: 18,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
