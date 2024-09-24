// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gatekeeper/Widgets/new_widgets/empty_list.dart';
import 'package:gatekeeper/Widgets/new_widgets/app_gradient.dart';
import 'package:gatekeeper/Widgets/new_widgets/loading.dart';
import 'package:gatekeeper/Widgets/new_widgets/my_button.dart';
import 'package:gatekeeper/Widgets/new_widgets/my_elipse.dart';
import 'package:gatekeeper/utils/Constants/images_strings.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:gatekeeper/utils/styles/text_style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/Constants/constants.dart';
import '../../../Routes/set_routes.dart';
import '../../../Widgets/new_widgets/my_back_button.dart';
import '../../../Widgets/new_widgets/my_dialog_box.dart';
import '../Controller/visitor_detail_controller.dart';

class VisitorDetailScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VisitorDetailController>(
        init: VisitorDetailController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              Get.offNamed(homescreen, arguments: controller.userdata);
              return false;
            },
            child: SafeArea(
              child: Scaffold(
                  backgroundColor: AppColors.background,
                  floatingActionButton: Container(
                    decoration: BoxDecoration(
                      gradient: AppGradients.floatingbuttonGradient,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                        iconSize: 50,
                        icon: Icon(Icons.add, color: AppColors.globalWhite),
                        onPressed: () {
                          Get.offNamed(addVistorDetailScreen,
                              arguments: controller.userdata);
                        }),
                  ),
                  body: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Column(
                      children: [
                        MyBackButton(
                          text: 'visitor'.tr,
                          onTap: () {
                            Get.offNamed(homescreen,
                                arguments: controller.userdata);
                          },
                        ),
                        if (controller.status == Status.completed) ...[
                          Expanded(
                            child: FutureBuilder(
                                future: controller.getVisitorDetails(
                                  societyId: controller.userdata.societyid!,
                                ),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    if (controller.visitorDetailsModel.data !=
                                            null &&
                                        controller.visitorDetailsModel.data
                                                ?.length !=
                                            0) {
                                      return ListView.builder(
                                          itemBuilder: (context, index) {
                                            var visitorsList = controller
                                                .visitorDetailsModel
                                                .data?[index];
                                            if (visitorsList?.status == 0) {
                                              return GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (BuildContext
                                                                  context) =>
                                                              AlertDialog(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .globalWhite,
                                                                surfaceTintColor:
                                                                    AppColors
                                                                        .globalWhite,
                                                                title:
                                                                    Directionality(
                                                                  textDirection:
                                                                      TextDirection
                                                                          .ltr,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Center(
                                                                          child:
                                                                              Text(
                                                                        visitorsList?.name ??
                                                                            "",
                                                                        style: reusableTextStyle(
                                                                            textStyle: GoogleFonts
                                                                                .dmSans(),
                                                                            fontSize:
                                                                                16.0,
                                                                            color:
                                                                                AppColors.textBlack,
                                                                            fontWeight: FontWeight.bold),
                                                                      )),
                                                                      SizedBox(
                                                                        height:
                                                                            37,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          MyElipse(),
                                                                          SizedBox(
                                                                            width:
                                                                                8,
                                                                          ),
                                                                          Text(
                                                                            'Description',
                                                                            style: reusableTextStyle(
                                                                                textStyle: GoogleFonts.dmSans(),
                                                                                fontSize: 16.0,
                                                                                color: AppColors.textBlack,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: 30),
                                                                        child:
                                                                            Text(
                                                                          visitorsList?.houseaddress ??
                                                                              "",
                                                                          style: reusableTextStyle(
                                                                              textStyle: GoogleFonts.dmSans(),
                                                                              fontSize: 14.0,
                                                                              color: AppColors.dark,
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            30,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          MyElipse(),
                                                                          SizedBox(
                                                                            width:
                                                                                8,
                                                                          ),
                                                                          Text(
                                                                            'Date',
                                                                            style: reusableTextStyle(
                                                                                textStyle: GoogleFonts.dmSans(),
                                                                                fontSize: 16.0,
                                                                                color: AppColors.textBlack,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                70,
                                                                          ),
                                                                          MyElipse(),
                                                                          SizedBox(
                                                                            width:
                                                                                8,
                                                                          ),
                                                                          Text(
                                                                            'Vehicle No',
                                                                            style: reusableTextStyle(
                                                                                textStyle: GoogleFonts.dmSans(),
                                                                                fontSize: 16.0,
                                                                                color: AppColors.textBlack,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            11,
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: 30),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(
                                                                              laravelDateToFormattedDate(visitorsList?.arrivaldate.toString() ?? ""),
                                                                              style: reusableTextStyle(textStyle: GoogleFonts.dmSans(), fontSize: 14.0, color: AppColors.dark, fontWeight: FontWeight.normal),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 70,
                                                                            ),
                                                                            Flexible(
                                                                              child: Text(
                                                                                visitorsList?.vechileno ?? "",
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: reusableTextStyle(textStyle: GoogleFonts.dmSans(), fontSize: 14.0, color: AppColors.dark, fontWeight: FontWeight.normal),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            30,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          MyElipse(),
                                                                          SizedBox(
                                                                            width:
                                                                                8,
                                                                          ),
                                                                          Text(
                                                                            'Check-In Time',
                                                                            style: reusableTextStyle(
                                                                                textStyle: GoogleFonts.dmSans(),
                                                                                fontSize: 16.0,
                                                                                color: AppColors.textBlack,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            11,
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: 30),
                                                                        child:
                                                                            Text(
                                                                          Hour12formatTime(visitorsList?.arrivaltime ??
                                                                              ""),
                                                                          style: reusableTextStyle(
                                                                              textStyle: GoogleFonts.dmSans(),
                                                                              fontSize: 14.0,
                                                                              color: AppColors.dark,
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            30,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          MyElipse(),
                                                                          SizedBox(
                                                                            width:
                                                                                8,
                                                                          ),
                                                                          Text(
                                                                            'Visitor Type',
                                                                            style: reusableTextStyle(
                                                                                textStyle: GoogleFonts.dmSans(),
                                                                                fontSize: 16.0,
                                                                                color: AppColors.textBlack,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            11,
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: 30),
                                                                        child:
                                                                            Text(
                                                                          visitorsList?.visitortype ??
                                                                              "",
                                                                          style: reusableTextStyle(
                                                                              textStyle: GoogleFonts.dmSans(),
                                                                              fontSize: 14.0,
                                                                              color: AppColors.dark,
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            34,
                                                                      ),
                                                                      MyButton(
                                                                        name:
                                                                            "Ok",
                                                                        gradient:
                                                                            AppGradients.buttonGradient,
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        width: double
                                                                            .infinity,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ));
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 13, 22, 0),
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    height: 90,
                                                    child: Card(
                                                      color:
                                                          AppColors.globalWhite,
                                                      surfaceTintColor:
                                                          AppColors.globalWhite,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      child: Stack(
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Container(
                                                                width: 110,
                                                                height: 27,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: AppColors
                                                                          .appThem),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    4,
                                                                  ),
                                                                  color: AppColors
                                                                      .appThem,
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              14),
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .calendar_month,
                                                                        size:
                                                                            15,
                                                                        color: AppColors
                                                                            .globalWhite,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        laravelDateToFormattedDate(visitorsList?.arrivaldate.toString() ??
                                                                            ""),
                                                                        style: reusableTextStyle(
                                                                            textStyle: GoogleFonts
                                                                                .dmSans(),
                                                                            fontSize:
                                                                                10.0,
                                                                            color:
                                                                                AppColors.globalWhite,
                                                                            fontWeight: FontWeight.normal),
                                                                      )
                                                                    ],
                                                                  ),
                                                                )),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    13,
                                                                    13,
                                                                    0,
                                                                    0),
                                                            child: Text(
                                                              visitorsList
                                                                      ?.name ??
                                                                  "",
                                                              style: reusableTextStyle(
                                                                  textStyle:
                                                                      GoogleFonts
                                                                          .dmSans(),
                                                                  fontSize:
                                                                      18.0,
                                                                  color: AppColors
                                                                      .textBlack,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      13,
                                                                      40,
                                                                      0,
                                                                      0),
                                                              child: Text.rich(
                                                                  TextSpan(
                                                                      children: [
                                                                    TextSpan(
                                                                      text:
                                                                          'Vehicle No :',
                                                                      style: reusableTextStyle(
                                                                          textStyle: GoogleFonts
                                                                              .dmSans(),
                                                                          fontSize:
                                                                              12.0,
                                                                          color: AppColors
                                                                              .dark,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    TextSpan(
                                                                      text: visitorsList
                                                                          ?.vechileno,
                                                                      style: reusableTextStyle(
                                                                          textStyle: GoogleFonts
                                                                              .dmSans(),
                                                                          fontSize:
                                                                              12.0,
                                                                          color: AppColors
                                                                              .dark,
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                    ),
                                                                  ]))),
                                                          (visitorsList
                                                                      ?.status ==
                                                                  0)
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          40,
                                                                          14,
                                                                          0),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child: MyStatusWidget(
                                                                        onTap: () {
                                                                          showDialog(
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return GetBuilder<VisitorDetailController>(
                                                                                    init: VisitorDetailController(),
                                                                                    builder: (visitorController) {
                                                                                      return Obx(() => CustomDialog(
                                                                                            loading: controller.isLoading.value,
                                                                                            image: Image.asset(
                                                                                              AppImages.warning,
                                                                                              color: AppColors.globalWhite,
                                                                                            ),
                                                                                            negativeBtnPressed: () {
                                                                                              Navigator.pop(context);
                                                                                            },
                                                                                            title: "Do you want to Checkout this?",
                                                                                            positiveBtnText: "Checkout",
                                                                                            negativeBtnText: "Cancel",
                                                                                            // loading: visitorController.isLoading,
                                                                                            positiveBtnPressed: () async {
                                                                                              visitorController.currentDate = visitorController.currentDateTime.year.toString() + "-" + visitorController.currentDateTime.month.toString() + "-" + visitorController.currentDateTime.day.toString();

                                                                                              visitorController.currentTime = visitorController.currentDateTime.hour.toString() + ":" + visitorController.currentDateTime.minute.toString() + ":" + visitorController.currentDateTime.second.toString();

                                                                                              if (!visitorController.isLoading.value) {
                                                                                                visitorController.updateVisitorDetailApi(vid: visitorsList?.id ?? 0, checkoutdate: visitorController.currentDate!, checkouttime: visitorController.currentTime!, context: context);
                                                                                              }
                                                                                            },
                                                                                          ));
                                                                                    });
                                                                              });
                                                                        },
                                                                        status: 'Check-Out',
                                                                        color: HexColor('#E85C5C')),
                                                                  ),
                                                                )
                                                              : Container(),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    13,
                                                                    60,
                                                                    0,
                                                                    0),
                                                            child: Text(
                                                              visitorsList
                                                                      ?.houseaddress ??
                                                                  "",
                                                              style: GoogleFonts.ubuntu(
                                                                  color: HexColor(
                                                                      '#A5AAB7'),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return EmptyList(
                                                name: 'No Visitor',
                                              );
                                            }
                                          },
                                          itemCount: controller
                                              .visitorDetailsModel
                                              .data
                                              ?.length);
                                    } else {
                                      return EmptyList(
                                        name: 'No Visitors',
                                      );
                                    }
                                  } else if (snapshot.hasError) {
                                    return CircularIndicatorUnderWhiteBox();
                                  } else {
                                    return CircularIndicatorUnderWhiteBox();
                                  }
                                }),
                          ),
                        ] else if (controller.status == Status.loading) ...[
                          CircularIndicatorUnderWhiteBox()
                        ] else ...[
                          EmptyList(
                            name: 'Something Went Wrong',
                          )
                        ],
                      ],
                    ),
                  )),
            ),
          );
        });
  }

  Widget MyStatusWidget(
      {required status,
      required color,
      Color? textColor,
      double? width,
      double? height,
      void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 64,
        height: height ?? 18,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
        child: Center(
          child: Text(
            status,
            style: TextStyle(
              fontSize: 10,
              color: textColor ?? HexColor('#FFFFFF'),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
