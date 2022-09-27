import 'package:bloodgency/components/bottom_navigation.dart';
import 'package:bloodgency/components/card_request.dart';
import 'package:bloodgency/models/features_model.dart';
import 'package:bloodgency/models/navitationitem_model.dart';
import 'package:bloodgency/screens/donation_screen.dart';
import 'package:bloodgency/screens/not_available_screen.dart';
import 'package:bloodgency/screens/request_donor_screen.dart';
import 'package:bloodgency/values/CustomColors.dart';
import 'package:bloodgency/values/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  final int navigationIndex = 0;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentNavigation = 0;
  List<String> banner = [
    "assets/images/banner.png",
    "assets/images/banner.png",
    "assets/images/banner.png",
    "assets/images/banner.png",
  ];

  List<FeaturesModel> features = [
    FeaturesModel(
      image: "assets/images/features/search.png",
      label: "Cari Calon Pendonor",
      onTap: (BuildContext context) {},
    ),
    FeaturesModel(
      image: "assets/images/features/donate.png",
      label: "Donor",
      onTap: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotAvailableScreen(),
          ),
        );
      },
    ),
    FeaturesModel(
      image: "assets/images/features/request.png",
      label: "Minta Darah",
      onTap: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RequestDonorScreen(),
          ),
        );
      },
    ),
    FeaturesModel(
      image: "assets/images/features/assistant.png",
      label: "Asisten",
      onTap: (BuildContext context) {},
    ),
    FeaturesModel(
      image: "assets/images/features/report.png",
      label: "Laporan",
      onTap: (BuildContext context) {},
    ),
    FeaturesModel(
      image: "assets/images/features/campaign.png",
      label: "Campaign",
      onTap: (BuildContext context) {},
    ),
  ];
  int carousel_page = 0;
  final PageController _carouselController = PageController();

  // Carousel Indikator
  List<Widget> carouselIndicators(length, currentIndex) {
    return List<Widget>.generate(length, (index) {
      return Container(
        margin: EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? primary : devider,
            shape: BoxShape.circle),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_outlined,
              size: 30,
              color: subText,
            ),
          )
        ],
      ),
      body: Container(
        color: white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                  height: 200.0,
                  child: PageView.builder(
                    controller: _carouselController,
                    itemCount: banner.length,
                    pageSnapping: true,
                    onPageChanged: (value) {
                      setState(() {
                        carousel_page = value;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        padding: EdgeInsets.zero,
                        color: textField,
                        child: Image.asset(
                          banner[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: carouselIndicators(banner.length, carousel_page),
              ),
              SizedBox(
                height: 300,
                child: GridView.builder(
                  itemCount: features.length,
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  // crossAxisSpacing: 20,
                  // mainAxisSpacing: 20,
                  // crossAxisCount: 3,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    FeaturesModel feature = features[index];
                    return GestureDetector(
                      onTap: () {
                        feature.onTap(context);
                      },
                      child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: boxShadow['light'],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage(
                                  feature.image,
                                ),
                              ),
                              Text(
                                feature.label,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: subText,
                                  fontSize: 14,
                                  fontFamily: 'Poppins-Medium',
                                ),
                              )
                            ],
                          )),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Permintaan Donor",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: text,
                              fontSize: 20,
                              fontFamily: 'Poppins-SemiBold',
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DonationRequestScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Lihat Semua",
                              style: TextStyle(
                                color: primary,
                                fontSize: 14,
                                fontFamily: "Poppins-Medium",
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      DonorRequestCard(
                        terkumpul: 0,
                        total: 10,
                        pasien: "Amir Hamza",
                        lokasi: "RS. Umum Provinsi NTB",
                        waktu: "5 menit yang lalu",
                        darah: "b+",
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
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
