import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gatekeeper/Module/HomeScreen/Controller/home_screen_controller.dart';
import 'package:gatekeeper/utils/Constants/constants.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                HexColor('#FB7712'),
                HexColor('#FF9900'),
              ])),
              child: Stack(
                children: [
                  Text(
                    "Gatekeeper App",
                    style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2,
                        fontSize: 15),
                  ),
                ],
              )),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: primaryColor,
            ),
            title: Text("Logout"),
            onTap: () async {
              await FirebaseMessaging.instance.deleteToken();
              final HomeScreenController _homeScreenController = Get.find();
              _homeScreenController.logoutApi(
                  token: _homeScreenController.user.bearerToken!);
            },
          ),
        ],
      ),
    );
  }
}
