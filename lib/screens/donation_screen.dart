import 'dart:convert';

import 'package:bloodgency/components/appbar.dart';
import 'package:bloodgency/components/bottom_navigation.dart';
import 'package:bloodgency/components/card_request.dart';
import 'package:bloodgency/models/request_model.dart';
import 'package:bloodgency/providers/request_provider.dart';
import 'package:bloodgency/screens/request_donor_screen.dart';
import 'package:bloodgency/utils/utils.dart';
import 'package:bloodgency/values/CustomColors.dart';
import 'package:bloodgency/values/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:faker/faker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:timezone/standalone.dart' as tz;
import 'package:web_socket_channel/web_socket_channel.dart';

class DonationRequestScreen extends StatefulWidget {
  const DonationRequestScreen({Key? key}) : super(key: key);
  @override
  State<DonationRequestScreen> createState() => _DonationRequestScreenState();
}

class _DonationRequestScreenState extends State<DonationRequestScreen> {
  var faker = new Faker();
  List<DonationRequestModel> requests = [];
  bool _showAppbar = true;
  ScrollController _scrollViewController = new ScrollController();
  bool isScrollingDown = false, _isLoading = false;

  final detroit = tz.getLocation("Asia/Makassar");
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
    final requestProvider = Provider.of<BloodRequestProvider>(context);
    requests = requestProvider.getRequest;
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://oxidized-sand-search.glitch.me'),
    );
    return Scaffold(
      backgroundColor: _isLoading ? primary : white,
      body: _isLoading
          ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.white,
                size: 200,
              ),
            )
          : SafeArea(
              child: Column(
                children: [
                  CustomAppBar(
                    title: "Permintaan Darah",
                    show: _showAppbar,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollViewController,
                      child: Container(
                        color: white,
                        margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:
                              List<Widget>.generate(requests.length, (index) {
                            DonationRequestModel request = requests[index];
                            var waktu = DateTime.parse(request.waktu);
                            var selisih = DateTime.now().difference(waktu);
                            return DonorRequestCard(
                              pasien: request.pasien,
                              request: request,
                              lokasi: request.lokasi,
                              darah: request.darah,
                              waktu: selisih.inMinutes > 60
                                  ? tz.TZDateTime.from(waktu, detroit)
                                      .toString()
                                  : "${selisih.inMinutes} Menit yang lalu",
                              terkumpul: request.terkumpul,
                              total: request.total,
                              borderRadius: BorderRadius.circular(10),
                              margin: EdgeInsets.only(top: 15, bottom: 15),
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
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ],
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
              currentNavigation: 2,
            ),
    );
  }
}
