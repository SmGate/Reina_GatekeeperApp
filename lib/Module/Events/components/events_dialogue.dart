import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gatekeeper/Helpers/Date%20Helper/date_helper.dart';
import 'package:gatekeeper/Widgets/new_widgets/app_gradient.dart';
import 'package:gatekeeper/Widgets/new_widgets/my_button.dart';
import 'package:gatekeeper/utils/Constants/constants.dart';
import 'package:gatekeeper/utils/Constants/images_strings.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:gatekeeper/utils/styles/text_style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EventDialog extends StatelessWidget {
  final String? title;
  final String? description;
  final String? startDate;
  final String? endDate;
  final String? startTime;
  final String? endTime;

  const EventDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.startTime,
      required this.endTime});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "event".tr,
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 18.0,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.bold),
              ),
            ),
            14.h.ph,
            Text(
              'title'.tr,
              style: reusableTextStyle(
                  textStyle: GoogleFonts.dmSans(),
                  fontSize: 16.0,
                  color: AppColors.textBlack,
                  fontWeight: FontWeight.bold),
            ),
            4.h.ph,
            Text(
              title ?? "",
              style: reusableTextStyle(
                  textStyle: GoogleFonts.dmSans(),
                  fontSize: 14.0,
                  color: AppColors.dark,
                  fontWeight: FontWeight.normal),
            ),
            14.h.ph,
            Text(
              'description'.tr,
              style: reusableTextStyle(
                  textStyle: GoogleFonts.dmSans(),
                  fontSize: 16.0,
                  color: AppColors.textBlack,
                  fontWeight: FontWeight.bold),
            ),
            4.h.ph,
            Text(
              description ?? "",
              style: reusableTextStyle(
                  textStyle: GoogleFonts.dmSans(),
                  fontSize: 14.0,
                  color: AppColors.dark,
                  fontWeight: FontWeight.normal),
            ),
            20.h.ph,
            Row(
              children: [
                Text(
                  'from'.tr,
                  style: reusableTextStyle(
                      textStyle: GoogleFonts.dmSans(),
                      fontSize: 16.0,
                      color: AppColors.textBlack,
                      fontWeight: FontWeight.bold),
                ),
                82.w.pw,
                Text(
                  'to'.tr,
                  style: reusableTextStyle(
                      textStyle: GoogleFonts.dmSans(),
                      fontSize: 16.0,
                      color: AppColors.textBlack,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            10.h.ph,
            Row(
              children: [
                SvgPicture.asset(
                  AppImages.date,
                  width: 25.w,
                  height: 25.w,
                  color: AppColors.textBlack,
                ),
                11.w.pw,
                Text(
                  DateHelper.convertDateFormatToDayMonthYearDateFormat(
                      startDate!),
                  style: reusableTextStyle(
                      textStyle: GoogleFonts.dmSans(),
                      fontSize: 14.0,
                      color: AppColors.dark,
                      fontWeight: FontWeight.normal),
                ),
                11.w.pw,
                SvgPicture.asset(
                  AppImages.date,
                  width: 25.w,
                  height: 25.w,
                  color: AppColors.textBlack,
                ),
                11.w.pw,
                Text(
                  DateHelper.convertDateFormatToDayMonthYearDateFormat(
                      endDate!),
                  style: reusableTextStyle(
                      textStyle: GoogleFonts.dmSans(),
                      fontSize: 14.0,
                      color: AppColors.dark,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
            20.h.ph,
            Row(
              children: [
                Text(
                  'from'.tr,
                  style: reusableTextStyle(
                      textStyle: GoogleFonts.dmSans(),
                      fontSize: 16.0,
                      color: AppColors.textBlack,
                      fontWeight: FontWeight.bold),
                ),
                82.w.pw,
                Text(
                  'to'.tr,
                  style: reusableTextStyle(
                      textStyle: GoogleFonts.dmSans(),
                      fontSize: 16.0,
                      color: AppColors.textBlack,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            10.h.ph,
            Row(
              children: [
                SvgPicture.asset(
                  AppImages.time,
                  width: 25.w,
                  height: 25.w,
                  color: AppColors.textBlack,
                ),
                11.w.pw,
                Text(
                  DateHelper.formatTimeToAMPM(startTime!),
                  style: reusableTextStyle(
                      textStyle: GoogleFonts.dmSans(),
                      fontSize: 14.0,
                      color: AppColors.dark,
                      fontWeight: FontWeight.normal),
                ),
                36.w.pw,
                SvgPicture.asset(
                  AppImages.time,
                  width: 25.w,
                  height: 25.w,
                  color: AppColors.textBlack,
                ),
                11.w.pw,
                Text(
                  DateHelper.formatTimeToAMPM(endTime!),
                  style: reusableTextStyle(
                      textStyle: GoogleFonts.dmSans(),
                      fontSize: 14.0,
                      color: AppColors.dark,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            40.h.ph,
            Center(
              child: MyButton(
                gradient: AppGradients.buttonGradient,
                width: double.infinity,
                name: 'ok'.tr,
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
