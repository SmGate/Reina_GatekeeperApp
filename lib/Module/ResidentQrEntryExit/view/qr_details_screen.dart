import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gatekeeper/Module/ResidentQrEntryExit/controller/resident_qr_entry_exit_controller.dart';
import 'package:gatekeeper/Routes/set_routes.dart';
import 'package:gatekeeper/Widgets/new_widgets/custom_container.dart';
import 'package:gatekeeper/Widgets/new_widgets/my_back_button.dart';
import 'package:gatekeeper/Widgets/new_widgets/my_button.dart';
import 'package:gatekeeper/utils/Constants/api_routes.dart';
import 'package:gatekeeper/utils/Constants/app_gradient.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:gatekeeper/utils/styles/text_style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class QrDetailsScreen extends StatelessWidget {
  final int? userId;
  final String? firstName;
  final String? lastName;
  final String? address;
  final String? roleName;
  final String? mobile;
  final String? image;

  const QrDetailsScreen({
    super.key,
    this.userId,
    this.firstName,
    this.lastName,
    this.address,
    this.roleName,
    this.mobile,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ResidentQrEntryController>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: [
              MyBackButton(
                text: 'resident_history'.tr,
                onTap: () {
                  Get.offNamed(homescreen, arguments: controller.userdata);
                },
              ),
              CustomCard(
                  margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                  onTap: () {},
                  child: Column(
                    children: [
                      if (image != null && image!.isNotEmpty)
                        Container(
                          margin: EdgeInsets.all(20),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(300),
                            child: CachedNetworkImage(
                              imageUrl: "${Api.imageBaseUrl}${image}",
                              placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                color: AppColors.appThem,
                              )),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.cover,
                              height: 200,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name",
                                  style: reusableTextStyle(
                                      textStyle: GoogleFonts.dmSans(),
                                      fontSize: 14.0,
                                      color: AppColors.textBlack,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Address",
                                  style: reusableTextStyle(
                                      textStyle: GoogleFonts.dmSans(),
                                      fontSize: 14.0,
                                      color: AppColors.textBlack,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Mobile",
                                  style: reusableTextStyle(
                                      textStyle: GoogleFonts.dmSans(),
                                      fontSize: 14.0,
                                      color: AppColors.textBlack,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Role",
                                  style: reusableTextStyle(
                                      textStyle: GoogleFonts.dmSans(),
                                      fontSize: 14.0,
                                      color: AppColors.textBlack,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${firstName} ${lastName}",
                                  style: reusableTextStyle(
                                      textStyle: GoogleFonts.dmSans(),
                                      fontSize: 14.0,
                                      color: AppColors.dark,
                                      fontWeight: FontWeight.normal),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  address ?? "",
                                  style: reusableTextStyle(
                                      textStyle: GoogleFonts.dmSans(),
                                      fontSize: 14.0,
                                      color: AppColors.dark,
                                      fontWeight: FontWeight.normal),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  mobile ?? "",
                                  style: reusableTextStyle(
                                      textStyle: GoogleFonts.dmSans(),
                                      fontSize: 14.0,
                                      color: AppColors.dark,
                                      fontWeight: FontWeight.normal),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  roleName ?? "",
                                  style: reusableTextStyle(
                                      textStyle: GoogleFonts.dmSans(),
                                      fontSize: 14.0,
                                      color: AppColors.dark,
                                      fontWeight: FontWeight.normal),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Obx(() => MyButton(
                              gradient: AppGradients.buttonGradient,
                              name: "GO",
                              loading: controller.loading.value,
                              onPressed: () {
                                controller.updateResidentEntryStatus(
                                    societyId: controller.userdata.societyid,
                                    residentId: userId,
                                    gatekeeperId: controller.userdata.userid,
                                    subadminid: controller.userdata.subadminid);
                              },
                            )),
                      ),
                      SizedBox(height: 10),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

Widget QrText({
  String? text1,
  String? text2,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text1 ?? "",
        style: reusableTextStyle(
            textStyle: GoogleFonts.dmSans(),
            fontSize: 14.0,
            color: AppColors.textBlack,
            fontWeight: FontWeight.bold),
      ),
      SizedBox(
        width: 80,
      ),
      Text(
        text2 ?? "",
        style: reusableTextStyle(
            textStyle: GoogleFonts.dmSans(),
            fontSize: 14.0,
            color: AppColors.dark,
            fontWeight: FontWeight.normal),
      ),
    ],
  );
}
