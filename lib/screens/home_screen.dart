import 'dart:convert';

import 'package:bloodgency/components/bottom_navigation.dart';
import 'package:bloodgency/components/card_request.dart';
import 'package:bloodgency/models/features_model.dart';
import 'package:bloodgency/models/navitationitem_model.dart';
import 'package:bloodgency/models/request_model.dart';
import 'package:bloodgency/providers/request_provider.dart';
import 'package:bloodgency/screens/donation_screen.dart';
import 'package:bloodgency/screens/find_donor_screen.dart';
import 'package:bloodgency/screens/login_screen.dart';
import 'package:bloodgency/screens/not_available_screen.dart';
import 'package:bloodgency/screens/onboarding_screen.dart';
import 'package:bloodgency/screens/request_donor_screen.dart';
import 'package:bloodgency/utils/utils.dart';
import 'package:bloodgency/values/CustomColors.dart';
import 'package:bloodgency/values/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:timezone/standalone.dart' as tz;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  final int navigationIndex = 0;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool isLogin = false;
  final detroit = tz.getLocation('Asia/Makassar');
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://oxidized-sand-search.glitch.me'),
  );
  Map<String, String> headers = {};
  String? token;
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
      onTap: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FindDonorScreen(),
          ),
        );
      },
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
      image: "assets/images/features/report.png",
      label: "Laporan",
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
      image: "assets/images/features/campaign.png",
      label: "Campaign",
      onTap: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotAvailableScreen(),
          ),
        );
      },
    ),
  ];
  int carousel_page = 0;
  final PageController _carouselController = PageController();
  bool _isLoading = false;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    Utils.isLogin(context).then((value) {
      setState(() {
        isLogin = value['isLogin'];
        token = value['token'];
        if (value['isLogin']) {
          headers['Authorization'] = 'Bearer ${token}';
        }
      });
      if (!value['isLogin']) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }
    });
  }

  void fetchDataRequest(requestProvider) {
    setState(() {
      _isLoading = true;
    });
    Utils.internet.fetch(
      context: context,
      url: Endpoint['request_lists'],
      headers: headers,
      onError: (response) async {
        Map<String, dynamic> body = await jsonDecode(response!.body);
        print(body);
        setState(() {
          _isLoading = false;
        });
      },
      onSuccess: (response) async {
        Map<String, dynamic> body = await jsonDecode(response!.body);
        requestProvider.setRequest(body['data']);
        setState(() {
          _isLoading = false;
        });
      },
      onNoInternet: () {
        setState(() {
          _isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final requestProvider =
        Provider.of<BloodRequestProvider>(context, listen: true);
    List<DonationRequestModel> requests = requestProvider.getRequest;
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://oxidized-sand-search.glitch.me'),
    );
    Utils.MyAccount().then((data) {
      Map<String, dynamic> account = data['account'];
      channel.stream.listen(
        (message) {
          message = jsonDecode(message);
          print("============ WS MESSAGE ===============");
          print(message);
          if (message['action'] == 'request' &&
              message['action'] != account['id']) {
            requestProvider.addToFirst(message['data']);
          } else if (message['action'] == 'donate' &&
              message['to'] == account['id']) {
            fetchDataRequest(requestProvider);
          }
        },
      );
    });
    if (isLogin && requests.length == 0) {
      fetchDataRequest(requestProvider);
    }
    print(requests.length);
    DateTime waktu = DateTime.parse(requests.first.waktu);
    var selisih = DateTime.now().difference(waktu);

    return Scaffold(
      backgroundColor: _isLoading ? primary : white,
      appBar: _isLoading
          ? null
          : AppBar(
              elevation: 0,
              backgroundColor: white,
              actions: [
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications_outlined,
                        size: 30,
                        color: subText,
                      ),
                    ),
                    if (true)
                      Positioned(
                        top: 9,
                        left: 23,
                        child: Container(
                          margin: EdgeInsets.all(3),
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              color: primary, shape: BoxShape.circle),
                        ),
                      ),
                  ],
                )
              ],
            ),
      body: _isLoading
          ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.white,
                size: 200,
              ),
            )
          : Container(
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
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
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
                      children:
                          carouselIndicators(banner.length, carousel_page),
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
                                        builder: (context) =>
                                            DonationRequestScreen(),
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
                              request: requests.first,
                              terkumpul: requests.first.terkumpul,
                              total: requests.first.total,
                              pasien: requests.first.pasien,
                              lokasi: requests.first.lokasi,
                              waktu: selisih.inMinutes > 60
                                  ? tz.TZDateTime.from(waktu, detroit)
                                      .toString()
                                  : "${selisih.inMinutes} Menit yang lalu",
                              darah: requests.first.darah.toLowerCase(),
                              donate: () async {
                                setState(() {
                                  _isLoading = true;
                                });

                                Utils.internet.fetch(
                                  context: context,
                                  url: Endpoint['donate'],
                                  method: 'POST',
                                  autoIncludeAuthToken: true,
                                  body: {
                                    'jumlah': '1',
                                    'request': requests.first.id
                                  },
                                  onSuccess: (response) async {
                                    Map<String, dynamic> account =
                                        await Utils.MyAccount()
                                            .then((value) => value['account']);
                                    print("Sending message Donate");
                                    channel.sink.add(jsonEncode({
                                      'action': 'donate',
                                      'to': requests.first.user,
                                      'uid': account['id'],
                                      'request': requests.first.id
                                    }));
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  },
                                  onError: (response) async {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    Map<String, dynamic> body =
                                        await jsonDecode(response!.body);
                                    print(body);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "Terjadi kesalahan, ${body['err']}"),
                                    ));
                                  },
                                  onNoInternet: () {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Anda sedang offline"),
                                    ));
                                  },
                                );
                              },
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
      floatingActionButton: _isLoading
          ? null
          : FloatingActionButton(
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
      bottomNavigationBar: _isLoading
          ? null
          : CustomBottomNavigation(
              currentNavigation: currentNavigation,
            ),
    );
  }
}
