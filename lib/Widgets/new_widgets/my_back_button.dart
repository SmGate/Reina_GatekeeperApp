import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gatekeeper/utils/Constants/constants.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:gatekeeper/utils/styles/text_style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBackButton extends StatelessWidget {
  final String? text;
  final Widget? widget;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;

  const MyBackButton({this.text, this.widget, this.onTap, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.globalWhite, AppColors.gradientDark])),
      child: Padding(
        padding: EdgeInsets.only(top: 10.h, bottom: 10),
        child: Row(
          children: [
            // 15.w.pw,
            Container(
              margin: EdgeInsets.only(left: 20),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: AppColors.gradientDark,
                  borderRadius: BorderRadius.circular(12)),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
                color: AppColors.textBlack,
                onPressed: onTap ??
                    () {
                      Get.back();
                    },
              ),
            ),
            10.w.pw,
            Text(
              text ?? "",
              style: reusableTextStyle(
                  textStyle: GoogleFonts.dmSans(),
                  fontSize: 20.0,
                  color: AppColors.textBlack,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              child: widget,
            )
          ],
        ),
      ),
    );
  }
}
