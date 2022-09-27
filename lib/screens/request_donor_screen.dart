import 'package:bloodgency/components/appbar.dart';
import 'package:bloodgency/components/button_component.dart';
import 'package:bloodgency/components/text_editing.dart';
import 'package:bloodgency/values/CustomColors.dart';
import 'package:bloodgency/values/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class RequestDonorScreen extends StatefulWidget {
  const RequestDonorScreen({Key? key}) : super(key: key);

  @override
  State<RequestDonorScreen> createState() => _RequestDonorScreenState();
}

class _RequestDonorScreenState extends State<RequestDonorScreen> {
  bool _showAppbar = true;
  ScrollController _scrollViewController = new ScrollController();
  bool isScrollingDown = false;
  String _blood = 'A+';
  TextEditingController _address = new TextEditingController();
  TextEditingController _rumahSakit = new TextEditingController();
  TextEditingController _kontak = new TextEditingController();
  TextEditingController _note = new TextEditingController();

  showCompleteRequest(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: primary,
                ),
              )
            ],
          ),
          content: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage("assets/images/complete.png"),
                  fit: BoxFit.cover,
                ),
                Text(
                  "Berhasil Meminta Darah",
                  style: TextStyle(
                    color: subText,
                    fontFamily: "Poppins-Regular",
                    fontSize: 14,
                  ),
                ),
                PrimaryButton(
                    text: "Tutup",
                    onTap: () {
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }

      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              CustomAppBar(
                title: "Buat Permintaan Darah",
                show: _showAppbar,
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            print("Tapped");
                          },
                          child: CustomTextEditing(
                            controller: _address,
                            hint: "Alamat Rumah Sakit",
                            shadow: Colors.black54,
                            enabled: false,
                            prefixIcon: Icon(
                              Icons.pin_drop,
                              color: primary,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomTextEditing(
                          controller: _rumahSakit,
                          hint: "Nama Rumah Sakit",
                          shadow: Colors.black54,
                          prefixIcon: Icon(
                            Icons.apartment,
                            color: primary,
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomTextEditing(
                          hint: "Pilih Golongan Darah",
                          prefixIcon: Icon(
                            Icons.bloodtype,
                            color: primary,
                          ),
                          dropdown: true,
                          options: blood_category.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 20),
                        CustomTextEditing(
                          hint: "Kontak",
                          controller: _kontak,
                          type: TextInputType.phone,
                          prefixIcon: Icon(
                            Icons.phone,
                            color: primary,
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomTextEditing(
                          controller: _note,
                          hint: "Catatan",
                          prefixIcon: Icon(
                            Icons.note,
                            color: primary,
                          ),
                          line: 5,
                        ),
                        SizedBox(height: 50),
                        PrimaryButton(
                          text: "Minta Darah",
                          onTap: () async {
                            showCompleteRequest(context);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
