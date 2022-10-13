import 'package:bloodgency/components/appbar.dart';
import 'package:bloodgency/components/bottom_navigation.dart';
import 'package:bloodgency/screens/login_screen.dart';
import 'package:bloodgency/screens/request_donor_screen.dart';
import 'package:bloodgency/values/CustomColors.dart';
import 'package:bloodgency/values/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileScrenn extends StatefulWidget {
  const ProfileScrenn({super.key});

  @override
  State<ProfileScrenn> createState() => _ProfileScrennState();
}

class _ProfileScrennState extends State<ProfileScrenn> {
  bool _mendonor = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Profile",
              action: GestureDetector(
                onTap: () {
                  print("edit");
                },
                child: Image(
                  image: AssetImage("assets/images/edit.png"),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: white,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                          image: NetworkImage(
                              "https://kamscode.site/ta/menuorder/assets/img/avatar/3vCZ5225.jpg"),
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Fahmi Ekan",
                        style: TextStyle(
                          color: text,
                          fontSize: 28,
                          fontFamily: "Poppins-SemiBold",
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            width: 20,
                            height: 20,
                            image: AssetImage("assets/images/pin.png"),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Mataram, NTB",
                            style: TextStyle(
                              color: subText,
                              fontSize: 20,
                              fontFamily: "Poppins-Regular",
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: boxShadow['light'],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "A+",
                                  style: TextStyle(
                                    color: text,
                                    fontSize: 28,
                                    fontFamily: "Poppins-SemiBold",
                                  ),
                                ),
                                Text(
                                  "Golongan Darah",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: subText,
                                    fontSize: 14,
                                    fontFamily: 'Poppins-Medium',
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: boxShadow['light'],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "05",
                                  style: TextStyle(
                                    color: text,
                                    fontSize: 28,
                                    fontFamily: "Poppins-SemiBold",
                                  ),
                                ),
                                Text(
                                  "Donasi/Donor",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: subText,
                                    fontSize: 14,
                                    fontFamily: 'Poppins-Medium',
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: boxShadow['light'],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "02",
                                  style: TextStyle(
                                    color: text,
                                    fontSize: 28,
                                    fontFamily: "Poppins-SemiBold",
                                  ),
                                ),
                                Text(
                                  "Meminta",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: subText,
                                    fontSize: 14,
                                    fontFamily: 'Poppins-Medium',
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: white,
                          boxShadow: boxShadow['medium'],
                        ),
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              _mendonor = !_mendonor;
                            });
                          },
                          visualDensity: VisualDensity.compact,
                          leading: Icon(
                            Icons.edit_calendar,
                            color: primary,
                          ),
                          title: Text(
                            "Bersedia Mendonor",
                            style: TextStyle(
                              color: subText,
                              fontSize: 20,
                              fontFamily: "Poppins-Medium",
                            ),
                          ),
                          trailing: Switch(
                            activeColor: primary,
                            value: _mendonor,
                            onChanged: (bool val) {
                              setState(() {
                                _mendonor = val;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: white,
                          boxShadow: boxShadow['medium'],
                        ),
                        child: ListTile(
                          onTap: () {
                            print("Invite Teman");
                          },
                          visualDensity: VisualDensity.compact,
                          leading: Icon(
                            Icons.message,
                            color: primary,
                          ),
                          title: Text(
                            "Undang Teman",
                            style: TextStyle(
                              color: subText,
                              fontSize: 20,
                              fontFamily: "Poppins-Medium",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: white,
                          boxShadow: boxShadow['medium'],
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          visualDensity: VisualDensity.compact,
                          leading: Icon(
                            Icons.logout,
                            color: primary,
                          ),
                          title: Text(
                            "Keluar",
                            style: TextStyle(
                              color: subText,
                              fontSize: 20,
                              fontFamily: "Poppins-Medium",
                            ),
                          ),
                        ),
                      ),
                    ],
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
        currentNavigation: 3,
      ),
    );
  }
}
