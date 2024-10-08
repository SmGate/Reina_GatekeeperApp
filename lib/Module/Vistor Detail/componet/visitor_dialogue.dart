import 'package:flutter/material.dart';
import 'package:gatekeeper/Module/Vistor%20Detail/Model/visitor_detail_model.dart';
import 'package:gatekeeper/Widgets/new_widgets/my_button.dart';
import 'package:gatekeeper/Widgets/new_widgets/my_elipse.dart';
import 'package:gatekeeper/utils/Constants/app_gradient.dart';
import 'package:gatekeeper/utils/Constants/constants.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:gatekeeper/utils/styles/text_style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

AlertDialog VisitorDialogue(Datum visitors, BuildContext context) {
  return AlertDialog(
    backgroundColor: AppColors.globalWhite,
    surfaceTintColor: AppColors.globalWhite,
    title: Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(
            visitors.name ?? "",
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 16.0,
                color: AppColors.textBlack,
                fontWeight: FontWeight.bold),
          )),
          SizedBox(
            height: 37,
          ),
          Row(
            children: [
              MyElipse(),
              SizedBox(
                width: 8,
              ),
              Text(
                'description'.tr,
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 16.0,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              visitors.houseaddress ?? "",
              style: reusableTextStyle(
                  textStyle: GoogleFonts.dmSans(),
                  fontSize: 14.0,
                  color: AppColors.dark,
                  fontWeight: FontWeight.normal),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              MyElipse(),
              SizedBox(
                width: 8,
              ),
              Text(
                'date'.tr,
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 16.0,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 70,
              ),
              MyElipse(),
              SizedBox(
                width: 8,
              ),
              Text(
                'vehicle_no'.tr,
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 16.0,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 11,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: Row(
              children: [
                Text(
                  laravelDateToFormattedDate(visitors.arrivaldate.toString()),
                  style: reusableTextStyle(
                      textStyle: GoogleFonts.dmSans(),
                      fontSize: 14.0,
                      color: AppColors.dark,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  width: 70,
                ),
                Flexible(
                  child: Text(
                    visitors.vechileno ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: reusableTextStyle(
                        textStyle: GoogleFonts.dmSans(),
                        fontSize: 14.0,
                        color: AppColors.dark,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              MyElipse(),
              SizedBox(
                width: 8,
              ),
              Text(
                'checkIn_time'.tr,
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 16.0,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 11,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              Hour12formatTime(visitors.arrivaltime ?? ""),
              style: reusableTextStyle(
                  textStyle: GoogleFonts.dmSans(),
                  fontSize: 14.0,
                  color: AppColors.dark,
                  fontWeight: FontWeight.normal),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              MyElipse(),
              SizedBox(
                width: 8,
              ),
              Text(
                'visitor_type'.tr,
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 16.0,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 11,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              visitors.visitortype ?? "",
              style: reusableTextStyle(
                  textStyle: GoogleFonts.dmSans(),
                  fontSize: 14.0,
                  color: AppColors.dark,
                  fontWeight: FontWeight.normal),
            ),
          ),
          SizedBox(
            height: 34,
          ),
          MyButton(
            name: "ok".tr,
            gradient: AppGradients.buttonGradient,
            onPressed: () {
              Navigator.pop(context);
            },
            width: double.infinity,
          )
        ],
      ),
    ),
  );
}
