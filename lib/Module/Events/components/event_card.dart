import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gatekeeper/Helpers/Date%20Helper/date_helper.dart';
import 'package:gatekeeper/utils/Constants/api_routes.dart';
import 'package:gatekeeper/utils/Constants/constants.dart';
import 'package:gatekeeper/utils/Constants/images_strings.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:gatekeeper/utils/styles/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

class EventCard extends StatelessWidget {
  final String? title;
  final String? description;
  final String? startDate;
  final int? index;
  final String? img;

  const EventCard(
      {super.key,
      required this.title,
      required this.img,
      required this.description,
      required this.startDate,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(14.w, 13.h, 18.w, 0),
        child: SizedBox(
            //  height: 96.w,
            width: 343.w,
            child: Card(
                color: AppColors.globalWhite,
                surfaceTintColor: AppColors.globalWhite,
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 13.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          10.h.ph,
                          SizedBox(
                            width: 200.w,
                            height: 20.w,
                            child: Text(
                              title ?? "",
                              style: reusableTextStyle(
                                  textStyle: GoogleFonts.dmSans(),
                                  fontSize: 16.0,
                                  color: AppColors.textBlack,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          6.h.ph,
                          SizedBox(
                            width: 200.w,
                            child: Text(
                              description ?? "",
                              style: reusableTextStyle(
                                  textStyle: GoogleFonts.dmSans(),
                                  fontSize: 12.0,
                                  color: AppColors.dark,
                                  fontWeight: FontWeight.normal),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          10.h.ph,
                          Row(
                            children: [
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
                                      DateHelper
                                          .convertDateFormatToDayMonthYearDateFormat(
                                              startDate!),
                                      style: reusableTextStyle(
                                          textStyle: GoogleFonts.dmSans(),
                                          fontSize: 10.0,
                                          color: AppColors.globalWhite,
                                          fontWeight: FontWeight.normal),
                                    )
                                  ],
                                ),
                              ),
                              12.w.pw,
                            ],
                          ),
                          10.h.ph,
                        ],
                      ),
                    ),
                    // if (index! % 2 == 0) ...[
                    //   Expanded(
                    //     child: SvgPicture.asset(
                    //       'assets/event_vector_2.svg',
                    //       width: 84.w,
                    //       height: 75.w,
                    //     ),
                    //   ),
                    // ],
                    // if (!(index! % 2 == 0)) ...[
                    //   Expanded(
                    //     child: SvgPicture.asset(
                    //       'assets/event_vector_1.svg',
                    //       width: 84.w,
                    //       height: 75.w,
                    //     ),
                    //   ),
                    // ]

                    Container(
                      margin: EdgeInsets.only(right: 20),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: "${Api.imageBaseUrl}$img",
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                                  child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.appThem,
                            ),
                          )),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    )
                  ],
                ))));
  }
}
