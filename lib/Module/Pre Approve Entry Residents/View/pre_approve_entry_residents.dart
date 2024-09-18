import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gatekeeper/Widgets/new_widgets/loading.dart';
import 'package:gatekeeper/utils/Constants/api_routes.dart';
import 'package:gatekeeper/Routes/set_routes.dart';
import 'package:gatekeeper/Widgets/new_widgets/empty_list.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:gatekeeper/utils/styles/text_style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/Constants/constants.dart';
import '../../../Widgets/new_widgets/my_back_button.dart';
import '../Controller/pre_approve_entry_residents_controller.dart';

class PreApproveEntryResidents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreApproveEntryResdientsController>(
        init: PreApproveEntryResdientsController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
                backgroundColor: AppColors.background,
                body: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Column(
                    children: [
                      MyBackButton(
                        text: 'residents'.tr,
                      ),
                      22.h.ph,
                      Expanded(
                        child: FutureBuilder(
                            future: controller.preApproveEntryResident(
                              userid: controller.userdata.userid!,
                            ),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                if (controller.preApprovedEntryModel.data !=
                                        null &&
                                    controller.preApprovedEntryModel.data!
                                            .length !=
                                        0) {
                                  return ListView.builder(
                                      itemBuilder: (context, index) {
                                        var preApprovedEntryList = controller
                                            .preApprovedEntryModel.data![index];
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.w,
                                              vertical: index == 0 ? 0 : 10.h),
                                          child: SizedBox(
                                            width: double.infinity,
                                            //  height: 80.w,
                                            child: Card(
                                              color: AppColors.globalWhite,
                                              surfaceTintColor:
                                                  AppColors.globalWhite,
                                              elevation: 1,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, bottom: 8.0),
                                                child: ListTile(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          right: 10, left: 0),
                                                  titleTextStyle:
                                                      reusableTextStyle(
                                                          textStyle: GoogleFonts
                                                              .dmSans(),
                                                          fontSize: 14.0,
                                                          color: AppColors
                                                              .textBlack,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                  subtitleTextStyle:
                                                      reusableTextStyle(
                                                          textStyle: GoogleFonts
                                                              .dmSans(),
                                                          fontSize: 12.0,
                                                          color: AppColors.dark,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                  onTap: () {
                                                    Get.toNamed(
                                                        preApprovedGuests,
                                                        arguments: [
                                                          preApprovedEntryList,
                                                          controller.userdata
                                                              .bearerToken!
                                                        ]);
                                                  },
                                                  leading: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20),
                                                    child: CachedNetworkImage(
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          image: DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                      ),
                                                      width: 60,
                                                      height: 60,
                                                      imageUrl: Api
                                                              .imageBaseUrl +
                                                          preApprovedEntryList
                                                              .image
                                                              .toString(),
                                                      placeholder:
                                                          (context, url) =>
                                                              Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color:
                                                              AppColors.appThem,
                                                        ),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    ),
                                                  ),
                                                  title: Text(
                                                      "${preApprovedEntryList.firstname.toString()} ${preApprovedEntryList.lastname.toString()}"),
                                                  subtitle: Text(
                                                      "${preApprovedEntryList.address.toString()}"),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: controller
                                          .preApprovedEntryModel.data!.length);
                                } else {
                                  return EmptyList(
                                    name: 'No Residents',
                                  );
                                }
                              } else if (snapshot.hasError) {
                                return CircularIndicatorUnderWhiteBox();
                              } else {
                                return CircularIndicatorUnderWhiteBox();
                              }
                            }),
                      ),
                    ],
                  ),
                )),
          );
        });
  }
}
