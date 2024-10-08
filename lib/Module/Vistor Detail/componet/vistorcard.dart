// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gatekeeper/Module/Vistor%20Detail/Controller/visitor_detail_controller.dart';
import 'package:gatekeeper/Module/Vistor%20Detail/Model/visitor_detail_model.dart';
import 'package:gatekeeper/Module/Vistor%20Detail/View/vistor_detail_screen.dart';
import 'package:gatekeeper/Widgets/new_widgets/my_dialog_box.dart';
import 'package:gatekeeper/utils/Constants/constants.dart';
import 'package:gatekeeper/utils/Constants/images_strings.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:gatekeeper/utils/styles/text_style.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class VisitorCard extends StatelessWidget {
  final Datum visitors;
  VisitorDetailController controller;
  VisitorCard({super.key, required this.visitors, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
          color: AppColors.globalWhite,
          surfaceTintColor: AppColors.globalWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                    width: 110,
                    height: 27,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.appThem),
                      borderRadius: BorderRadius.circular(
                        4,
                      ),
                      color: AppColors.appThem,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 14),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 15,
                            color: AppColors.globalWhite,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            laravelDateToFormattedDate(
                                visitors.arrivaldate.toString()),
                            style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 10.0,
                                color: AppColors.globalWhite,
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: SizedBox(
                  width: 150,
                  child: Text(
                    visitors.name ?? "",
                    style: reusableTextStyle(
                        textStyle: GoogleFonts.dmSans(),
                        fontSize: 16.0,
                        color: AppColors.textBlack,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: Row(
                  children: [
                    Text.rich(TextSpan(children: [
                      TextSpan(
                        text: 'Vehicle No :',
                        style: reusableTextStyle(
                            textStyle: GoogleFonts.dmSans(),
                            fontSize: 12.0,
                            color: AppColors.dark,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: visitors.vechileno,
                        style: reusableTextStyle(
                            textStyle: GoogleFonts.dmSans(),
                            fontSize: 12.0,
                            color: AppColors.dark,
                            fontWeight: FontWeight.normal),
                      ),
                    ])),
                    Spacer(),
                    (visitors.status == 0)
                        ? MyStatusWidget(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return GetBuilder<VisitorDetailController>(
                                        init: VisitorDetailController(),
                                        builder: (visitorController) {
                                          return Obx(() => CustomDialog(
                                                loading:
                                                    controller.isLoading.value,
                                                image: Image.asset(
                                                  AppImages.warning,
                                                  color: AppColors.globalWhite,
                                                ),
                                                negativeBtnPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                title:
                                                    "Do you want to Checkout this?",
                                                positiveBtnText: "Checkout",
                                                negativeBtnText: "Cancel",
                                                // loading: visitorController.isLoading,
                                                positiveBtnPressed: () async {
                                                  visitorController
                                                          .currentDate =
                                                      visitorController
                                                              .currentDateTime
                                                              .year
                                                              .toString() +
                                                          "-" +
                                                          visitorController
                                                              .currentDateTime
                                                              .month
                                                              .toString() +
                                                          "-" +
                                                          visitorController
                                                              .currentDateTime
                                                              .day
                                                              .toString();

                                                  visitorController.currentTime =
                                                      visitorController
                                                              .currentDateTime
                                                              .hour
                                                              .toString() +
                                                          ":" +
                                                          visitorController
                                                              .currentDateTime
                                                              .minute
                                                              .toString() +
                                                          ":" +
                                                          visitorController
                                                              .currentDateTime
                                                              .second
                                                              .toString();

                                                  if (!visitorController
                                                      .isLoading.value) {
                                                    visitorController
                                                        .updateVisitorDetailApi(
                                                            vid: visitors.id ??
                                                                0,
                                                            checkoutdate:
                                                                visitorController
                                                                    .currentDate!,
                                                            checkouttime:
                                                                visitorController
                                                                    .currentTime!,
                                                            context: context);
                                                  }
                                                },
                                              ));
                                        });
                                  });
                            },
                            status: 'Check-Out',
                            color: HexColor('#E85C5C'))
                        : Container(),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
                child: Text(
                  visitors.houseaddress ?? "",
                  style: GoogleFonts.ubuntu(
                      color: HexColor('#A5AAB7'),
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          )),
    );
  }
}
