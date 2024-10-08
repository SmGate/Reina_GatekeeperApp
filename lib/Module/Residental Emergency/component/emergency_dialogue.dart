import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gatekeeper/Module/Residental%20Emergency/Controller/residential_emergency_controller.dart';
import 'package:gatekeeper/Widgets/new_widgets/dialog_box_elipse_heading.dart';
import 'package:gatekeeper/Widgets/new_widgets/my_button.dart';
import 'package:gatekeeper/utils/Constants/app_gradient.dart';
import 'package:gatekeeper/utils/Constants/constants.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:gatekeeper/utils/styles/text_style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyDialog extends StatelessWidget {
  final String? problem;
  final String? description;
  final String? address;
  final String? createdAt;
  final String? mobileNo;

  const EmergencyDialog({
    super.key,
    required this.problem,
    required this.description,
    required this.address,
    required this.createdAt,
    required this.mobileNo,
  });

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
                problem ?? "",
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 18.0,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.bold),
              ),
            ),
            14.h.ph,
            DialogBoxElipseHeading(
              text: "emergency_at".tr,
            ),
            8.95.h.ph,
            Padding(
              padding: EdgeInsets.only(left: 26.w),
              child: Text(
                createdAt!,
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 14.0,
                    color: AppColors.dark,
                    fontWeight: FontWeight.bold),
              ),
            ),
            8.95.h.ph,
            DialogBoxElipseHeading(
              text: "address".tr,
            ),
            8.95.h.ph,
            Padding(
              padding: EdgeInsets.only(left: 26.w),
              child: Text(
                address ?? "",
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 14.0,
                    color: AppColors.dark,
                    fontWeight: FontWeight.bold),
              ),
            ),
            8.95.h.ph,
            DialogBoxElipseHeading(
              text: "mobile".tr,
            ),
            Padding(
              padding: EdgeInsets.only(left: 26.w),
              child: Row(
                children: [
                  Text(
                    mobileNo ?? "",
                    style: reusableTextStyle(
                        textStyle: GoogleFonts.dmSans(),
                        fontSize: 14.0,
                        color: AppColors.dark,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  IconButton(
                      onPressed: () async {
                        final ResidentialEmergencyController controller =
                            Get.find();
                        controller.uri = Uri.parse("tel://${mobileNo}");

                        try {
                          await launchUrl(controller.uri!);
                          controller.uri = null;
                        } catch (e) {
                          myToast(msg: e.toString(), isNegative: true);
                        }
                      },
                      icon: Icon(
                        Icons.call,
                        color: Colors.green,
                      ))
                ],
              ),
            ),
            8.95.h.ph,
            DialogBoxElipseHeading(
              text: "description".tr,
            ),
            8.95.h.ph,
            Padding(
              padding: EdgeInsets.only(left: 26.w),
              child: Text(description ?? "",
                  style: GoogleFonts.ubuntu(
                      fontSize: 11.sp, color: HexColor('#333333'))),
            ),
            14.h.ph,
            Center(
              child: MyButton(
                gradient: AppGradients.buttonGradient,
                border: 300.r,
                width: double.infinity,
                height: 40.w,
                name: 'ok'.tr,
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            14.h.ph,
          ],
        ),
      ),
    );
  }
}
