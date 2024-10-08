import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gatekeeper/Helpers/Date%20Helper/date_helper.dart';
import 'package:gatekeeper/Module/ResidentQrEntryExit/model/checkedin_residents_model.dart';
import 'package:gatekeeper/Widgets/new_widgets/my_button.dart';
import 'package:gatekeeper/utils/Constants/app_gradient.dart';
import 'package:gatekeeper/utils/Constants/constants.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:gatekeeper/utils/styles/text_style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ResidentsDialogCard extends StatelessWidget {
  final Datum? residents;
  final String? title;
  final String? description;
  final String? startDate;
  final String? endDate;
  final String? startTime;
  final String? endTime;
  final int? status;

  const ResidentsDialogCard(
      {super.key,
      this.title,
      this.description,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.status,
      this.residents});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 347.w,
      child: SingleChildScrollView(
          child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
            child: Text(
              'resident'.tr,
              style: reusableTextStyle(
                  textStyle: GoogleFonts.dmSans(),
                  fontSize: 18.0,
                  color: AppColors.textBlack,
                  fontWeight: FontWeight.bold),
            ),
          ),
          14.h.ph,
          Text(
            'name'.tr,
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 16.0,
                color: AppColors.textBlack,
                fontWeight: FontWeight.bold),
          ),
          4.h.ph,
          Text(
            residents?.name ?? "",
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 14.0,
                color: AppColors.dark,
                fontWeight: FontWeight.normal),
          ),
          14.h.ph,
          Text(
            'address'.tr,
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 16.0,
                color: AppColors.textBlack,
                fontWeight: FontWeight.bold),
          ),
          4.h.ph,
          Text(
            residents?.houseaddress ?? "",
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 14.0,
                color: AppColors.dark,
                fontWeight: FontWeight.normal),
          ),
          14.h.ph,
          Text(
            'mobile'.tr,
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 16.0,
                color: AppColors.textBlack,
                fontWeight: FontWeight.bold),
          ),
          4.h.ph,
          Text(
            residents?.mobileno ?? "",
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 14.0,
                color: AppColors.dark,
                fontWeight: FontWeight.normal),
          ),
          Text(
            'visitor_type'.tr,
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 16.0,
                color: AppColors.textBlack,
                fontWeight: FontWeight.bold),
          ),
          4.h.ph,
          Text(
            residents?.visitortype ?? "",
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 14.0,
                color: AppColors.dark,
                fontWeight: FontWeight.normal),
          ),
          14.h.ph,
          Text(
            'vehicle_no'.tr,
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 16.0,
                color: AppColors.textBlack,
                fontWeight: FontWeight.bold),
          ),
          4.h.ph,
          Text(
            residents?.vechileno ?? "",
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 14.0,
                color: AppColors.dark,
                fontWeight: FontWeight.normal),
          ),
          14.h.ph,
          Text(
            'status'.tr,
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 16.0,
                color: AppColors.textBlack,
                fontWeight: FontWeight.bold),
          ),
          4.h.ph,
          Text(
            residents?.statusdescription ?? "",
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 14.0,
                color: AppColors.dark,
                fontWeight: FontWeight.normal),
          ),
          14.h.ph,
          Text(
            'exit_time'.tr,
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 16.0,
                color: AppColors.textBlack,
                fontWeight: FontWeight.bold),
          ),
          4.h.ph,
          Text(
            residents?.checkouttime ?? "",
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 14.0,
                color: AppColors.dark,
                fontWeight: FontWeight.normal),
          ),
          14.h.ph,
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'entry'.tr,
                    style: reusableTextStyle(
                        textStyle: GoogleFonts.dmSans(),
                        fontSize: 16.0,
                        color: AppColors.textBlack,
                        fontWeight: FontWeight.bold),
                  ),
                  11.w.pw,
                  Text(
                    residents!.arrivaldate != null
                        ? DateHelper.formatDate(
                            residents!.arrivaldate.toString())
                        : "NA",
                    style: reusableTextStyle(
                        textStyle: GoogleFonts.dmSans(),
                        fontSize: 14.0,
                        color: AppColors.dark,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'exit'.tr,
                    style: reusableTextStyle(
                        textStyle: GoogleFonts.dmSans(),
                        fontSize: 16.0,
                        color: AppColors.textBlack,
                        fontWeight: FontWeight.bold),
                  ),
                  11.w.pw,
                  Text(
                    residents!.checkoutdate != null
                        ? DateHelper.formatDate(
                            residents!.checkoutdate.toString())
                        : 'NA',
                    style: reusableTextStyle(
                      textStyle: GoogleFonts.dmSans(),
                      fontSize: 14.0,
                      color: AppColors.dark,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
          14.h.ph,
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
        ]),
      )),
    );
  }
}
