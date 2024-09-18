import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gatekeeper/utils/Constants/constants.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:gatekeeper/utils/styles/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/Constants/images_strings.dart';

Widget EmergencyCard(AsyncSnapshot<dynamic> snapshot, int index) {
  return Padding(
    padding: EdgeInsets.only(left: 24.w, right: 14.w, top: 15.h),
    child: SizedBox(
      width: 337.w,
      height: 80.w,
      child: Card(
        color: AppColors.globalWhite,
        surfaceTintColor: AppColors.globalWhite,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: AppColors.appThem,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 19.w),
              child: Image.asset(
                AppImages.emergency,
                height: 50,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 19.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    9.h.ph,
                    Text(
                      '${snapshot.data.data[index].problem}',
                      style: reusableTextStyle(
                          textStyle: GoogleFonts.dmSans(),
                          fontSize: 14.0,
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${snapshot.data.data[index].description}',
                      overflow: TextOverflow.ellipsis,
                      style: reusableTextStyle(
                          textStyle: GoogleFonts.dmSans(),
                          fontSize: 14.0,
                          color: AppColors.dark,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                11.h.ph,
                Text(
                  '${convertUtcToDayOfWeekWithOffset(snapshot.data.data[index].createdAt.toString())}',
                  style: reusableTextStyle(
                      textStyle: GoogleFonts.dmSans(),
                      fontSize: 14.0,
                      color: AppColors.dark,
                      fontWeight: FontWeight.normal),
                ),
                5.h.ph,
                Text(
                  '${convertUtcToFormattedTimeAdd5Hours(snapshot.data.data[index].createdAt.toString())}',
                  overflow: TextOverflow.ellipsis,
                  style: reusableTextStyle(
                      textStyle: GoogleFonts.dmSans(),
                      fontSize: 14.0,
                      color: AppColors.dark,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
      ),
    ),
  );
}
