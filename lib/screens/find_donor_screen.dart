import 'package:bloodgency/components/appbar.dart';
import 'package:bloodgency/components/bottom_navigation.dart';
import 'package:bloodgency/components/card_donors.dart';
import 'package:bloodgency/components/map_zoom_button.dart';
import 'package:bloodgency/screens/request_donor_screen.dart';
import 'package:bloodgency/values/CustomColors.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class FindDonorScreen extends StatefulWidget {
  const FindDonorScreen({Key? key}) : super(key: key);

  @override
  State<FindDonorScreen> createState() => _FindDonorScreenState();
}

class _FindDonorScreenState extends State<FindDonorScreen> {
  bool _showAppbar = true;
  ScrollController _scrollViewController = new ScrollController();
  bool isScrollingDown = false;
  var faker = Faker();
  int currentNavigation = 1;

  List<Map<String, dynamic>> _donors = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _donors = List.generate(35, (index) {
      return {
        "nama": faker.person.name(),
        "lokasi": faker.address.city(),
        "image": faker.image.image(
          keywords: ['people', 'photo', 'photo profile'],
        ),
        "darah": faker.randomGenerator.fromPattern(
          ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"],
        ),
        "margin": EdgeInsets.only(top: 15, bottom: 15)
      };
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

  void showBottomSheet(Map<String, dynamic> donor) async {
    Position? position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                margin: EdgeInsets.only(top: 60),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        donor["nama"],
                        style: TextStyle(
                          color: text,
                          fontSize: 20,
                          fontFamily: "Poppins-Medium",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.pin_drop,
                            color: primary,
                          ),
                          Text(
                            donor["lokasi"],
                            style: TextStyle(
                              color: subText,
                              fontSize: 14,
                              fontFamily: "Poppins-Regular",
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Image(
                                height: 37,
                                width: 37,
                                image:
                                    AssetImage("assets/images/gift_hand.png"),
                              ),
                              Row(
                                children: [
                                  Text("6",
                                      style: TextStyle(
                                        color: primary,
                                        fontSize: 14,
                                        fontFamily: "Poppins-Regular",
                                      )),
                                  Text(" Kali Mendonor",
                                      style: TextStyle(
                                        color: subText,
                                        fontSize: 14,
                                        fontFamily: "Poppins-Regular",
                                      )),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image(
                                height: 37,
                                width: 37,
                                image:
                                    AssetImage("assets/images/logo_darah.png"),
                              ),
                              Row(
                                children: [
                                  Text("Golongan Darah - ",
                                      style: TextStyle(
                                        color: subText,
                                        fontSize: 14,
                                        fontFamily: "Poppins-Regular",
                                      )),
                                  Text(donor['darah'],
                                      style: TextStyle(
                                        color: primary,
                                        fontSize: 14,
                                        fontFamily: "Poppins-Regular",
                                      )),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                              color: secondary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton.icon(
                              onPressed: () {
                                print("Call");
                              },
                              icon: Icon(
                                Icons.call,
                                color: white,
                              ),
                              label: Text(
                                "Hubungi",
                                style: TextStyle(color: white),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton.icon(
                              onPressed: () {
                                print("Request");
                              },
                              icon: Icon(
                                Icons.undo,
                                color: white,
                              ),
                              label: Text(
                                "Minta Darah",
                                style: TextStyle(color: white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: FlutterMap(
                          options: MapOptions(
                            center: LatLng(position!.latitude.toDouble(),
                                position.longitude.toDouble()),
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
                                  point: LatLng(position.latitude.toDouble(),
                                      position.longitude.toDouble()),
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
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -50,
                right: (MediaQuery.of(context).size.width - 100) * 0.5,
                child: Container(
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      width: 100,
                      image: NetworkImage(donor['image']),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
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
              title: "Cari Calon Pendonor",
              show: _showAppbar,
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollViewController,
                child: Container(
                  margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                  color: white,
                  child: Column(
                    children: List.generate(_donors.length, (index) {
                      Map<String, dynamic> donor = _donors[index];
                      return DonorCard(
                        key: Key(index.toString()),
                        nama: donor["nama"],
                        lokasi: donor["lokasi"],
                        image: donor["image"],
                        darah: donor["darah"],
                        margin: donor['margin'],
                        onTap: () {
                          showBottomSheet(donor);
                        },
                      );
                    }),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RequestDonorScreen(),
            ),
          );
        },
        backgroundColor: white,
        child: Container(
          height: 50,
          width: 50,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: primary,
            shape: BoxShape.circle,
          ),
          child: Image(
            color: white,
            image: AssetImage("assets/images/logo.png"),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentNavigation: currentNavigation,
      ),
    );
  }
}
