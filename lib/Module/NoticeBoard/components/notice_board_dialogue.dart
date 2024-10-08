import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gatekeeper/Helpers/Date%20Helper/date_helper.dart';
import 'package:gatekeeper/Widgets/new_widgets/complan_dialog_border.dart';
import 'package:gatekeeper/Widgets/new_widgets/dialog_box_elipse_heading.dart';
import 'package:gatekeeper/Widgets/new_widgets/my_button.dart';
import 'package:gatekeeper/utils/Constants/app_gradient.dart';
import 'package:gatekeeper/utils/Constants/constants.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:gatekeeper/utils/styles/text_style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NoticeBoardDialogCard extends StatelessWidget {
  final String? title;
  final String? description;
  final String? startDate;
  final String? endDate;
  final String? startTime;
  final String? endTime;
  final int? status;

  const NoticeBoardDialogCard(
      {super.key,
      required this.title,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.startTime,
      required this.endTime,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 347.w,
      child: SingleChildScrollView(
          child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (status == 0) ...[
            Center(
              child: Text(
                'notice_board'.tr,
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
            31.34.h.ph,
            DialogBoxElipseHeading(text: 'Date'),
            20.h.ph,
            Padding(
              padding: EdgeInsets.only(left: 26.6.w),
              child: Row(
                children: [
                  Text(
                    "from".tr,
                    style: reusableTextStyle(
                        textStyle: GoogleFonts.dmSans(),
                        fontSize: 16.0,
                        color: AppColors.textBlack,
                        fontWeight: FontWeight.bold),
                  ),
                  110.w.pw,
                  Text(
                    "to".tr,
                    style: reusableTextStyle(
                        textStyle: GoogleFonts.dmSans(),
                        fontSize: 16.0,
                        color: AppColors.textBlack,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            10.h.ph,
            Padding(
              padding: EdgeInsets.only(left: 26.6.w),
              child: Row(
                children: [
                  ComplainDialogBorderWidget(
                      text:
                          DateHelper.convertDateFormatToDayMonthYearDateFormat(
                              startDate!)),
                  15.w.pw,
                  ComplainDialogBorderWidget(
                      text:
                          DateHelper.convertDateFormatToDayMonthYearDateFormat(
                              endDate!)),
                ],
              ),
            ),
            10.h.ph,
            DialogBoxElipseHeading(text: 'Time'),
            20.h.ph,
            Padding(
              padding: EdgeInsets.only(left: 26.6.w),
              child: Row(
                children: [
                  Text(
                    "from".tr,
                    style: reusableTextStyle(
                        textStyle: GoogleFonts.dmSans(),
                        fontSize: 16.0,
                        color: AppColors.textBlack,
                        fontWeight: FontWeight.bold),
                  ),
                  110.w.pw,
                  Text(
                    "to".tr,
                    style: reusableTextStyle(
                        textStyle: GoogleFonts.dmSans(),
                        fontSize: 16.0,
                        color: AppColors.textBlack,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            10.h.ph,
            Padding(
              padding: EdgeInsets.only(left: 26.6.w),
              child: Row(
                children: [
                  ComplainDialogBorderWidget(
                      text: DateHelper.Hour12formatTime(startTime!)),
                  15.w.pw,
                  ComplainDialogBorderWidget(
                      text: DateHelper.Hour12formatTime(endTime!)),
                ],
              ),
            ),
            37.h.ph,
            Center(
              child: MyButton(
                gradient: AppGradients.buttonGradient,
                name: 'ok'.tr,
                width: double.infinity,
                height: 31.w,
                border: 7.r,
                onPressed: () {
                  Get.back();
                },
              ),
            )
          ] else ...[
            Center(
              child: Text(
                'notice_board'.tr,
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
            37.h.ph,
            Center(
              child: MyButton(
                gradient: AppGradients.buttonGradient,
                name: 'ok'.tr,
                width: double.infinity,
                height: 40.w,
                border: 7.r,
                onPressed: () {
                  Get.back();
                },
              ),
            )
          ]
        ]),
      )),
    );
  }
}
