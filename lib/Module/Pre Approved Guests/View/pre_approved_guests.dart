import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gatekeeper/Module/Pre%20Approved%20Guests/components/pre_approved_entry_dialogue.dart';
import 'package:gatekeeper/Module/Pre%20Approved%20Guests/model/pre_approved_guest_model.dart';
import 'package:gatekeeper/Widgets/new_widgets/loading.dart';
import 'package:gatekeeper/Widgets/new_widgets/my_textform_field.dart';
import 'package:gatekeeper/utils/Constants/constants.dart';
import 'package:gatekeeper/Module/Pre%20Approved%20Guests/Controller/pre_approve_entries_controller.dart';
import 'package:gatekeeper/utils/Constants/images_strings.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:gatekeeper/utils/styles/text_style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../Widgets/new_widgets/empty_list.dart';
import '../../../Widgets/new_widgets/my_back_button.dart';

class PreApprovedGuests extends GetView {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GetBuilder<PreApproveEntriesController>(
            init: PreApproveEntriesController(),
            builder: (controller) {
              return Scaffold(
                backgroundColor: AppColors.background,
                body: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Column(
                    children: [
                      MyBackButton(
                        text: 'pre_approved_entriese'.tr,
                      ),
                      if (controller.status == Status.completed) ...[
                        Expanded(
                          child: FutureBuilder<PreApprovedGuestModel>(
                              future: controller.preApproveGuest(
                                userid: controller.data.userid,
                              ),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  if (controller.preApprovedGuestModel.data !=
                                          null &&
                                      controller.preApprovedGuestModel.data!
                                              .length !=
                                          0) {
                                    return ListView.builder(
                                      itemCount: controller
                                          .preApprovedGuestModel.data!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var preApprovedEntryList = controller
                                            .preApprovedGuestModel.data![index];
                                        return GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext
                                                        context) =>
                                                    AlertDialog(
                                                        surfaceTintColor:
                                                            AppColors
                                                                .globalWhite,
                                                        backgroundColor:
                                                            AppColors
                                                                .globalWhite,
                                                        content:
                                                            PreApproveEntryDialog(
                                                          name:
                                                              preApprovedEntryList
                                                                  .name,
                                                          description:
                                                              preApprovedEntryList
                                                                  .description,
                                                          arrivaldate:
                                                              preApprovedEntryList
                                                                  .arrivaldate
                                                                  .toString(),
                                                          arrivaltime:
                                                              preApprovedEntryList
                                                                  .arrivaltime,
                                                          cnic:
                                                              preApprovedEntryList
                                                                  .cnic,
                                                          mobileno:
                                                              preApprovedEntryList
                                                                  .mobileno,
                                                          vechileno:
                                                              preApprovedEntryList
                                                                  .vechileno,
                                                          visitortype:
                                                              preApprovedEntryList
                                                                  .visitortype,
                                                        )));
                                          },
                                          child: PreApproveEntryCard(snapshot,
                                              index, controller, context),
                                        );
                                      },
                                    );
                                  } else {
                                    return EmptyList(
                                      name: 'No Preapprove Entry',
                                    );
                                  }
                                } else if (snapshot.hasError) {
                                  return CircularIndicatorUnderWhiteBox();
                                } else {
                                  return CircularIndicatorUnderWhiteBox();
                                }
                              }),
                        )
                      ] else if (controller.status == Status.loading) ...[
                        CircularIndicatorUnderWhiteBox()
                      ] else ...[
                        EmptyList(
                          name: 'Something Went Wrong',
                        )
                      ],
                    ],
                  ),
                ),
              );
            }));
  }

  Widget PreApproveEntryCard(AsyncSnapshot<dynamic> snapshot, int index,
      PreApproveEntriesController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: AppColors.globalWhite,
          surfaceTintColor: AppColors.globalWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(
                  AppImages.cardbg,
                  fit: BoxFit.fill,
                  color: AppColors.appThem,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(12, 11, 0, 0),
                child: Text(
                  snapshot.data.data[index].name,
                  style: reusableTextStyle(
                      textStyle: GoogleFonts.dmSans(),
                      fontSize: 14.0,
                      color: AppColors.textBlack,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(13, 32, 75, 0),
                child: Row(
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      'Visitor Type: ',
                      style: reusableTextStyle(
                          textStyle: GoogleFonts.dmSans(),
                          fontSize: 12.0,
                          color: AppColors.dark,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      snapshot.data.data[index].visitortype.toString(),
                      style: reusableTextStyle(
                          textStyle: GoogleFonts.dmSans(),
                          fontSize: 12.0,
                          color: AppColors.dark,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
                child: snapshot.data.data[index].status == 2
                    ? Row(
                        children: [
                          SizedBox(
                            width: 11.2,
                          ),
                          Text(
                            'Checkin Time: ',
                            style: GoogleFonts.ubuntu(
                                color: Colors.green,
                                fontSize: 10,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            Hour12formatTime(
                                snapshot.data.data[index].checkintime),
                            style: GoogleFonts.ubuntu(
                                color: HexColor('#A5AAB7'),
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          SizedBox(
                            width: 11.2,
                          ),
                          Text(
                            'Expected Arrival Time: ',
                            style: GoogleFonts.ubuntu(
                                color: HexColor('#A5AAB7'),
                                fontSize: 10,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            Hour12formatTime(
                                snapshot.data.data[index].arrivaltime),
                            style: GoogleFonts.ubuntu(
                                color: HexColor('#A5AAB7'),
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
              ),
              if (snapshot.data.data[index].status == 1) ...[
                GestureDetector(
                  onTap: () {
                    controller.cnicController.text =
                        snapshot.data.data[index].cnic.toString();
                    controller.vechilenoController.text =
                        snapshot.data.data[index].vechileno.toString();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              backgroundColor: AppColors.globalWhite,
                              surfaceTintColor: AppColors.globalWhite,
                              title: Directionality(
                                textDirection: TextDirection.ltr,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                        child: Text(
                                      'Pre Approve Entry',
                                      style: reusableTextStyle(
                                          textStyle: GoogleFonts.dmSans(),
                                          fontSize: 16.0,
                                          color: AppColors.textBlack,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    SizedBox(
                                      height: 24,
                                    ),
                                    Center(
                                      child: MyTextFormField(
                                        controller: controller.cnicController,
                                        width: 173,
                                        height: 30,
                                        labelText: "CNIC",
                                        hintText: 'CNIC',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    Center(
                                      child: MyTextFormField(
                                        controller:
                                            controller.vechilenoController,
                                        width: 173,
                                        height: 30,
                                        labelText: "VEHICLE NO",
                                        hintText: 'VEHICLE NO',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 37,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (!controller.isLoading.value) {
                                                controller
                                                    .updatePreApproveEntryStatusApi(
                                                        id: snapshot.data
                                                            .data[index].id!,
                                                        status: 2,
                                                        statusdescription:
                                                            'CheckIn',
                                                        cnic: controller
                                                            .cnicController
                                                            .text,
                                                        vechileno: controller
                                                            .vechilenoController
                                                            .text);
                                              }
                                            },
                                            child: MyStatusWidget(
                                              width: 81,
                                              height: 22,
                                              status: 'Check In',
                                              color: AppColors.appThem,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 13,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: MyStatusWidget(
                                              width: 81,
                                              height: 22,
                                              status: 'Cancel',
                                              color: HexColor('#BABABA'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 42, 14, 0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: MyStatusWidget(
                        width: 81,
                        height: 22,
                        status: 'Check In',
                        color: AppColors.appThem,
                      ),
                    ),
                  ),
                )
              ] else if (snapshot.data.data[index].status == 2) ...[
                GestureDetector(
                  onTap: () {
                    controller.updatePreapproveEntryCheckoutStatusApi(
                        id: snapshot.data.data[index].id!,
                        token: controller.token,
                        status: 3,
                        statusdescription: 'Checkout');
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 42, 14, 0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: MyStatusWidget(
                        width: 81,
                        height: 22,
                        status: 'Check out',
                        color: AppColors.appThem,
                      ),
                    ),
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget MyStatusWidget(
      {required status,
      required color,
      Color? textColor,
      double? width,
      double? height}) {
    return Container(
      width: width ?? 64,
      height: height ?? 18,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      child: Center(
        child: Text(
          status,
          style: TextStyle(
            fontSize: 10,
            color: textColor ?? HexColor('#FFFFFF'),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
