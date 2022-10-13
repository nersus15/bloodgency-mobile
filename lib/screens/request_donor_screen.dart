import 'package:bloodgency/components/appbar.dart';
import 'package:bloodgency/components/button_component.dart';
import 'package:bloodgency/components/map_zoom_button.dart';
import 'package:bloodgency/components/text_editing.dart';
import 'package:bloodgency/values/CustomColors.dart';
import 'package:bloodgency/values/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

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
  TextEditingController _jumlah = new TextEditingController();
  String coordinate = "";
  late LatLng tappedPoints;

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
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void showBottomSheet() async {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      context: context,
      builder: (BuildContext bc) {
        print("init Latling $tappedPoints");
        LatLng currPoint = tappedPoints;

        return StatefulBuilder(
          builder: (context, innserState) {
            print("Current Latling $currPoint");
            return Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: FlutterMap(
                options: MapOptions(
                  onTap: (tapPosition, point) {
                    print("Tap Latling $point");
                    innserState(() {
                      currPoint = point;
                      tappedPoints = point;
                    });
                  },
                  center: currPoint,
                  zoom: 15,
                ),
                nonRotatedChildren: const [
                  FlutterMapZoomButtons(
                    minZoom: 4,
                    mini: true,
                    padding: 10,
                    alignment: Alignment.bottomLeft,
                  ),
                ],
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.bloodgency',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: currPoint,
                        width: 80,
                        height: 80,
                        builder: (context) => Image(
                          image: AssetImage("assets/images/pin.png"),
                          color: primary,
                          height: 100,
                          width: 100,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      _address.text =
          "Koordinat: ${tappedPoints.latitude.toStringAsFixed(3)}, ${tappedPoints.longitude.toStringAsFixed(3)}";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      tappedPoints =
          LatLng(position.latitude.toDouble(), position.longitude.toDouble());
    });

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
                child: Container(
                  color: white,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Form(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showBottomSheet();
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
                          hint: "Jumlah",
                          controller: _jumlah,
                          type: TextInputType.number,
                          prefixIcon: const Icon(
                            Icons.bloodtype,
                            color: primary,
                          ),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
