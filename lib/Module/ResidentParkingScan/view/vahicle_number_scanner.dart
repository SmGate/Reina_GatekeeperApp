// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gatekeeper/Widgets/new_widgets/my_button.dart';
import 'package:gatekeeper/Widgets/new_widgets/my_textform_field.dart';
import 'package:gatekeeper/utils/Constants/app_gradient.dart';
import 'package:gatekeeper/utils/Constants/constants.dart';
import 'package:gatekeeper/utils/Constants/images_strings.dart';
import 'package:get/get.dart';
import 'package:gatekeeper/Routes/set_routes.dart';
import 'package:gatekeeper/Widgets/new_widgets/my_back_button.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import '../controller/vehicle_number_scanner_controller.dart';

class VehicleNumberScanner extends StatelessWidget {
  VehicleNumberScanner({super.key});

  @override
  Widget build(BuildContext context) {
    final VehicleNumberScannerController controller =
        Get.put(VehicleNumberScannerController());

    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(homescreen, arguments: controller.userdata);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.background,
          body: Obx(
            () => Directionality(
              textDirection: TextDirection.ltr,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    MyBackButton(
                      text: 'vehicle_detail'.tr,
                      onTap: () {
                        Get.offNamed(homescreen,
                            arguments: controller.userdata);
                      },
                    ),
                    // Added DefaultTabController and TabBar
                    DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 20, right: 20),
                            child: TabBar(
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.black,
                              indicator: BoxDecoration(
                                color: AppColors
                                    .appThem, // Selected tab background color
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              tabs: [
                                Tab(text: 'scan_car_number'.tr),
                                Tab(text: 'manual_input'.tr),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: TabBarView(
                              children: [
                                // First Tab - Scan Car Number
                                Column(
                                  children: [
                                    SizedBox(height: 20),
                                    Container(
                                      height: 200,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [],
                                      ),
                                      margin: EdgeInsets.only(top: 20),
                                      child: controller.image == null
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  top: 40,
                                                  bottom: 20),
                                              child:
                                                  Image.asset(AppImages.logo),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.file(
                                                File(controller.image!.path),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      '${'vehicle_number'.tr}: ${controller.vehicleNumber}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textBlack,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 20),
                                    controller.vehicleNumber.isEmpty
                                        ? MyButton(
                                            width:
                                                Get.locale?.languageCode == 'ur'
                                                    ? 250
                                                    : 180,
                                            gradient:
                                                AppGradients.buttonGradient,
                                            name: 'scan_vehicle_number'.tr,
                                            onPressed: () {
                                              controller
                                                  .captureAndExtractText();
                                            },
                                          )
                                        : MyButton(
                                            gradient:
                                                AppGradients.buttonGradient,
                                            loading: controller.loading.value,
                                            name: 'check_result'.tr,
                                            onPressed: () {
                                              controller.getVehicleOwnerData(
                                                  context: context,
                                                  vehicleNo:
                                                      controller.vehicleNumber);
                                            },
                                          ),
                                  ],
                                ),
                                // Second Tab - Manual Input
                                Form(
                                  key: controller.formKey,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 40,
                                            bottom: 20),
                                        child: Image.asset(AppImages.logo),
                                      ),
                                      SizedBox(height: 20),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: MyTextFormField(
                                          controller: controller.vNoController,
                                          hintText: "Enter vehicle number",
                                          labelText: "Enter vehicle number",
                                          validator: emptyStringValidator,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Obx(() => MyButton(
                                            loading: controller.loading.value,
                                            gradient:
                                                AppGradients.buttonGradient,
                                            name: 'Submit',
                                            onPressed: () {
                                              if (controller
                                                  .formKey.currentState!
                                                  .validate()) {
                                                String vehicleNumber = controller
                                                        .extractVehicleNumber(
                                                            controller
                                                                .vNoController
                                                                .text) ??
                                                    "";
                                                controller.getVehicleOwnerData(
                                                    vehicleNo: vehicleNumber,
                                                    context: context);
                                              }
                                            },
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
