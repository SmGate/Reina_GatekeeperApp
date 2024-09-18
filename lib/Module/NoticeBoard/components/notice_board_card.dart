import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gatekeeper/Helpers/Date%20Helper/date_helper.dart';
import 'package:gatekeeper/utils/Constants/constants.dart';
import 'package:gatekeeper/utils/Constants/images_strings.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:gatekeeper/utils/styles/text_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class NoticeboardCard extends StatelessWidget {
  final String? title;
  final String? description;
  final String? startDate;

  const NoticeboardCard(
      {super.key,
      required this.title,
      required this.description,
      required this.startDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 14.51.h, 16.w, 0),
      child: SizedBox(
        width: 343.w,
        height: 72.w,
        child: Card(
            color: AppColors.globalWhite,
            surfaceTintColor: AppColors.globalWhite,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 13.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 220.w,
                          child: Text(
                            title ?? '',
                            style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 18.0,
                                color: AppColors.textBlack,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      6.h.ph,
                      Expanded(
                        child: SizedBox(
                          width: 220.w,
                          child: Text(
                            description ?? '',
                            style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 14.0,
                                color: AppColors.dark,
                                fontWeight: FontWeight.normal),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 93.w,
                  height: 18.w,
                  decoration: BoxDecoration(
                      color: AppColors.appThem,
                      borderRadius: BorderRadius.circular(4.r)),
                  child: Row(
                    children: [
                      6.w.pw,
                      SvgPicture.asset(
                        AppImages.date,
                        width: 12.w,
                        height: 12.w,
                        color: AppColors.globalWhite,
                      ),
                      8.w.pw,
                      Text(
                          DateHelper.convertDateFormatToDayMonthYearDateFormat(
                              startDate!),
                          style: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.w300,
                              fontSize: 10.sp,
                              color: HexColor('#FFFFFF')))
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
