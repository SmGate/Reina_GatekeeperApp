// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:gatekeeper/Routes/set_routes.dart';
import 'package:gatekeeper/Services/Shared%20Preferences/MySharedPreferences.dart';
import 'package:gatekeeper/Widgets/new_widgets/custom_container.dart';

import 'package:gatekeeper/utils/Constants/images_strings.dart';
import 'package:gatekeeper/Module/HomeScreen/Controller/home_screen_controller.dart';
import 'package:gatekeeper/utils/Constants/instructions_label.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:gatekeeper/utils/styles/text_style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  final List local = [
    {'name': 'ENGLISH', 'local': Locale('en', 'Us')},
    {'name': 'اردو', 'local': Locale('ur', 'PK')}
  ];
  late FlutterTts flutterTts;

  // FlutterTts flutterTts = FlutterTts();

  Future<void> speakUrdu(String text) async {
    await flutterTts.speak(text);
  }

  Future<void> stopSpeaking() async {
    await flutterTts.stop();
  }

  bool isSpeaking = false;
  bool isSpeaking1 = false;
  bool isSpeaking2 = false;
  bool isSpeaking3 = false;
  bool isSpeaking4 = false;
  bool isSpeaking5 = false;
  bool isSpeaking6 = false;

  @override
  void initState() {
    super.initState();
    initializeTts();
  }

  void initializeTts() async {
    flutterTts = FlutterTts();
    await flutterTts.setLanguage("ur");

    flutterTts.setPitch(1.0);
    flutterTts.setSpeechRate(0.5);
    flutterTts.setVolume(1.0);

    // Set iOS audio category
    flutterTts.setSharedInstance(true);
    await flutterTts.setIosAudioCategory(
      IosTextToSpeechAudioCategory.playback,
      [
        IosTextToSpeechAudioCategoryOptions.allowBluetooth,
        IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
        IosTextToSpeechAudioCategoryOptions.mixWithOthers,
        IosTextToSpeechAudioCategoryOptions.defaultToSpeaker
      ],
      IosTextToSpeechAudioMode.defaultMode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
      builder: (controller) => SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            backgroundColor: AppColors.background,
            key: _scaffoldKey,
            // endDrawer: MyDrawer(),
            body: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(color: AppColors.appThem),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, top: 20, right: 20),
                          child: Row(
                            children: [
                              Text(
                                'home'.tr,
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 18.0,
                                    color: AppColors.globalWhite,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: () {
                                    _showBottomSheet(context);
                                  },
                                  icon: Icon(
                                    Icons.language,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 26,
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       left: languageCode == "ur" ? 10 : 20,
                        //       right: languageCode == "ur" ? 0 : 20),
                        //   child: Text(
                        //     "welcome".trParams({
                        //       "firstName": "${controller.user.firstName}",
                        //       "lastName": "${controller.user.lastName}"
                        //     }),
                        //     style: reusableTextStyle(
                        //         textStyle: GoogleFonts.dmSans(),
                        //         fontSize: 18.0,
                        //         color: AppColors.globalWhite,
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 13,
                        // ),
                        SizedBox(
                          height: 9,
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Center(
                          child: Container(
                            child: SvgPicture.asset(AppImages.buildingsIcon),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 20, right: 20),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                                onPressed: () {
                                  Get.offNamed(vistorDetailScreen,
                                      arguments: controller.user);
                                },
                                child: Text(
                                  "Add Visitor",
                                  style: reusableTextStyle(
                                      textStyle: GoogleFonts.dmSans(),
                                      fontSize: 12.0,
                                      color: AppColors.appThem,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        )
                      ]),
                ),
                CustomCard(
                  onTap: () {
                    Get.toNamed(preApproveEntryResidents,
                        arguments: controller.user);
                  },
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppColors.appThem,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              AppImages.preApprovedEntry,
                              color: AppColors.globalWhite,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: Get.locale?.languageCode == 'ur' ? 0 : 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'pre_approved_entriese'.tr,
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.textBlack,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 160,
                                child: Text(
                                  'you_can_pre_approve_visitor'.tr,
                                  style: reusableTextStyle(
                                      textStyle: GoogleFonts.dmSans(),
                                      fontSize: 12.0,
                                      color: AppColors.dark,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        isSpeaking == true
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    isSpeaking = false;
                                    stopSpeaking();

                                    print(isSpeaking);
                                  });
                                },
                                icon: Icon(Icons.volume_down_alt))
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    isSpeaking = true;
                                    speakUrdu(InstructionLabels
                                        .PRE_APPROVED_ENTRIESE_INS);
                                    print(isSpeaking);
                                  });
                                },
                                icon: Icon(Icons.volume_off)),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),

                //////////////////////////////

                CustomCard(
                  onTap: () {
                    Get.offNamed(vistorDetailScreen,
                        arguments: controller.user);
                  },
                  width: double.infinity,
                  margin:
                      EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppColors.appThem,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              AppImages.visitorDetail,
                              color: AppColors.globalWhite,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: Get.locale?.languageCode == 'ur' ? 20 : 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'visitor'.tr,
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.textBlack,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'visitor_details'.tr,
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 12.0,
                                    color: AppColors.dark,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        isSpeaking3 == true
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    isSpeaking3 = false;
                                    stopSpeaking();
                                    print(isSpeaking3);
                                  });
                                },
                                icon: Icon(Icons.volume_down_alt))
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    isSpeaking3 = true;
                                    speakUrdu(InstructionLabels.VISITOR_INS);

                                    print(isSpeaking3);
                                  });
                                },
                                icon: Icon(Icons.volume_off)),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),

                //////////////////////////////

                CustomCard(
                  onTap: () {
                    Get.toNamed(eventsscreen, arguments: controller.user);
                  },
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppColors.appThem,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              AppImages.events,
                              color: AppColors.globalWhite,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: Get.locale?.languageCode == 'ur' ? 0 : 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'events'.tr,
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.textBlack,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'you_can_view_events'.tr,
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.dark,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        isSpeaking1 == true
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    isSpeaking1 = false;
                                    stopSpeaking();

                                    print(isSpeaking1);
                                  });
                                },
                                icon: Icon(Icons.volume_down_alt))
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    isSpeaking1 = true;
                                    speakUrdu(InstructionLabels.EVENTS_INS);

                                    print(isSpeaking1);
                                  });
                                },
                                icon: Icon(Icons.volume_off)),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),

                //////////////////////////////

                CustomCard(
                  onTap: () {
                    Get.toNamed(noticeboardscreen, arguments: controller.user);
                  },
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppColors.appThem,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              AppImages.noticeBoard,
                              color: AppColors.globalWhite,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: Get.locale?.languageCode == 'ur' ? 20 : 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'notice_board'.tr,
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.textBlack,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'announcement_from_admin'.tr,
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 12.0,
                                    color: AppColors.dark,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        isSpeaking2 == true
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    isSpeaking2 = false;
                                    stopSpeaking();

                                    print(isSpeaking2);
                                  });
                                },
                                icon: Icon(Icons.volume_down_alt))
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    isSpeaking2 = true;
                                    speakUrdu(
                                        InstructionLabels.NOTICE_BOARD_INS);

                                    print(isSpeaking2);
                                  });
                                },
                                icon: Icon(Icons.volume_off)),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),

                //////////////////////////////

                CustomCard(
                  onTap: () {
                    Get.offNamed(residentialEmergencyScreen,
                        arguments: controller.user);
                  },
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppColors.appThem,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              AppImages.emergency,
                              color: AppColors.globalWhite,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: Get.locale?.languageCode == 'ur' ? 20 : 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'residential_emergency'.tr,
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.textBlack,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'residential_emergency'.tr,
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 12.0,
                                    color: AppColors.dark,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        isSpeaking4 == true
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    isSpeaking4 = false;
                                    stopSpeaking();
                                    print(isSpeaking4);
                                  });
                                },
                                icon: Icon(Icons.volume_down_alt))
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    isSpeaking4 = true;
                                    speakUrdu(InstructionLabels
                                        .RESIDENTIAL_EMERGENCY_INS);

                                    print(isSpeaking4);
                                  });
                                },
                                icon: Icon(Icons.volume_off)),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),

                /////////// wrong parking scaneed
                CustomCard(
                  onTap: () {
                    Get.offNamed(vehicleNumberScannerScreen,
                        arguments: controller.user);
                  },
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppColors.appThem,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              AppImages.parking,
                              color: AppColors.globalWhite,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: Get.locale?.languageCode == 'ur' ? 20 : 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'scan_parking'.tr,
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.textBlack,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 140,
                                child: Text(
                                  'scan_parked_resident'.tr,
                                  style: reusableTextStyle(
                                      textStyle: GoogleFonts.dmSans(),
                                      fontSize: 12.0,
                                      color: AppColors.dark,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        isSpeaking6 == true
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    isSpeaking6 = false;
                                    stopSpeaking();
                                    print(isSpeaking6);
                                  });
                                },
                                icon: Icon(Icons.volume_down_alt))
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    isSpeaking6 = true;
                                    speakUrdu(
                                        InstructionLabels.PARKING_SCANING_INS);

                                    print(isSpeaking6);
                                  });
                                },
                                icon: Icon(Icons.volume_off)),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),

                //////////////////////////////

                CustomCard(
                  onTap: () {
                    MySharedPreferences.deleteUserData();
                    Get.offAllNamed(loginscreen);
                  },
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: AppColors.appThem,
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(
                              Icons.login,
                              size: 30,
                              color: AppColors.globalWhite,
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: Get.locale?.languageCode == 'ur' ? 20 : 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'logout'.tr,
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.textBlack,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'logout_yourself'.tr,
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 12.0,
                                    color: AppColors.dark,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        isSpeaking5 == true
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    isSpeaking5 = false;
                                    stopSpeaking();

                                    print(isSpeaking5);
                                  });
                                },
                                icon: Icon(Icons.volume_down_alt))
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    isSpeaking5 = true;
                                    speakUrdu(InstructionLabels.LOGOUT_INS);

                                    print(isSpeaking5);
                                  });
                                },
                                icon: Icon(Icons.volume_off)),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }

  //////  METHOD FOR TEXT TO SPEECH

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppColors.globalWhite,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SELECT LANGUAGE",
                  style: TextStyle(fontSize: 20),
                ),
                Container(
                  height: 150,
                  padding: EdgeInsets.all(16.0),
                  child: ListView.builder(
                      itemCount: local.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: index == 0 ? 0 : 10),
                              child: SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shadowColor: AppColors.globalWhite,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        surfaceTintColor: AppColors.globalWhite,
                                        backgroundColor: AppColors.globalWhite),
                                    onPressed: () {
                                      _setLanguage(local[index]['local']);
                                    },
                                    child: Text(
                                      local[index]['name'],
                                      style:
                                          TextStyle(color: AppColors.appThem),
                                    )),
                              ),
                            ),
                            // ),
                            // Divider()
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _setLanguage(
    Locale local,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('languageCode', local.languageCode);
    preferences.setString('countryCode', local.countryCode ?? '');

    Get.back();
    Get.updateLocale(local);
  }
}
