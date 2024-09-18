// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gatekeeper/Module/Residental%20Emergency/Model/residential_emergency_model.dart';
import 'package:gatekeeper/Module/Residental%20Emergency/component/emergency_card.dart';
import 'package:gatekeeper/Module/Residental%20Emergency/component/emergency_dialogue.dart';
import 'package:gatekeeper/Widgets/new_widgets/empty_list.dart';
import 'package:gatekeeper/Widgets/new_widgets/loading.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:get/get.dart';
import '../../../utils/Constants/constants.dart';
import '../../../Routes/set_routes.dart';
import '../../../Widgets/new_widgets/my_back_button.dart';
import '../Controller/residential_emergency_controller.dart';

class ResidentialEmergencyScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResidentialEmergencyController>(
        init: ResidentialEmergencyController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              Get.offNamed(homescreen, arguments: controller.userdata);
              return false;
            },
            child: SafeArea(
              child: Scaffold(
                  backgroundColor: AppColors.background,
                  body: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Column(
                      children: [
                        MyBackButton(
                          text: 'emergency'.tr,
                          onTap: () {
                            Get.offNamed(homescreen,
                                arguments: controller.userdata);
                          },
                        ),
                        22.h.ph,
                        Expanded(
                          child: FutureBuilder<ResidentialEmergencyModel>(
                              future: controller.residentialEmergency(
                                subadminid: controller.userdata.subadminid!,
                              ),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  if (controller
                                              .residentialEmergencyModel.data !=
                                          null &&
                                      controller.residentialEmergencyModel.data!
                                              .length !=
                                          0) {
                                    return ListView.builder(
                                        itemBuilder: (context, index) {
                                          var emergencyList = controller
                                              .residentialEmergencyModel
                                              .data![index];
                                          return GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                          context) =>
                                                      AlertDialog(
                                                        backgroundColor:
                                                            AppColors
                                                                .globalWhite,
                                                        surfaceTintColor:
                                                            AppColors
                                                                .globalWhite,
                                                        content: EmergencyDialog(
                                                            problem:
                                                                emergencyList
                                                                    .problem,
                                                            createdAt: laravelDateToFormattedDate(
                                                                emergencyList
                                                                    .createdAt
                                                                    .toString()),
                                                            address: snapshot
                                                                .data!
                                                                .data![index]
                                                                .resident
                                                                .first
                                                                .address,
                                                            mobileNo: snapshot
                                                                .data!
                                                                .data![index]
                                                                .resident
                                                                .first
                                                                .mobileno,
                                                            description:
                                                                emergencyList
                                                                    .description),
                                                      ));
                                            },
                                            child:
                                                EmergencyCard(snapshot, index),
                                          );
                                        },
                                        itemCount: controller
                                            .residentialEmergencyModel
                                            .data
                                            ?.length);
                                  } else {
                                    return EmptyList(
                                      name: "No Emergency Reported.",
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
            ),
          );
        });
  }
}
