// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:gatekeeper/Module/QrScanner/controller/qr_entry_controller.dart';
import 'package:gatekeeper/Module/QrScanner/model/qr_data_model.dart';
import 'package:gatekeeper/Routes/set_routes.dart';
import 'package:gatekeeper/Widgets/new_widgets/custom_container.dart';
import 'package:gatekeeper/Widgets/new_widgets/my_back_button.dart';
import 'package:gatekeeper/Widgets/new_widgets/my_button.dart';
import 'package:gatekeeper/utils/Constants/api_routes.dart';
import 'package:gatekeeper/utils/Constants/app_gradient.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrDetailsScreen extends StatelessWidget {
  QrData qrData;
  QRViewController qrcontrolle;
  QrDetailsScreen({super.key, required this.qrData, required this.qrcontrolle});

  @override
  Widget build(BuildContext context) {
    var qrEntryController = Get.find<QrEntryController>();
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(homescreen, arguments: qrEntryController.userdata);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            children: [
              MyBackButton(
                text: 'Scanned Data Details'.tr,
                onTap: () {
                  Get.offNamed(homescreen,
                      arguments: qrEntryController.userdata);
                },
              ),
              qrData.type == "resident"
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: CustomCard(
                        onTap: () {},
                        color: AppColors.globalWhite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 80,
                                width: 80,
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(300),
                                  child: Image.network(
                                    "${Api.imageBaseUrl}${qrData.image}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              _buildDataRow('Type:', qrData.type ?? ""),
                              _buildDataRow(
                                  'User ID:', qrData.userId.toString()),
                              _buildDataRow(
                                  'Resident ID:', qrData.residentId.toString()),
                              _buildDataRow('Name:',
                                  '${qrData.firstName} ${qrData.lastName}'),
                              _buildDataRow('Address:', qrData.address ?? ""),
                              _buildDataRow('Mobile:', qrData.mobile ?? ""),
                              SizedBox(
                                height: 40,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    MyButton(
                                      width: 120,
                                      gradient: AppGradients.buttonGradient,
                                      name: "Cancel",
                                      onPressed: () {
                                        Get.offNamed(homescreen,
                                            arguments:
                                                qrEntryController.userdata);
                                      },
                                    ),
                                    Spacer(),
                                    Obx(() => MyButton(
                                          width: 120,
                                          loading:
                                              qrEntryController.loading.value,
                                          gradient: AppGradients.buttonGradient,
                                          name: "Done",
                                          onPressed: () async {
                                            // await qrcontrolle
                                            //     .pauseCamera(); // Optional, pauses the camera

                                            // qrcontrolle.dispose();
                                            qrEntryController
                                                .updateResidentEntryStatus(
                                              societyId: qrEntryController
                                                  .userdata.societyid,
                                              residentId: qrData.residentId,
                                              gatekeeperId: qrEntryController
                                                  .userdata.userid,
                                              subadminid: qrEntryController
                                                  .userdata.subadminid,
                                            );
                                          },
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: CustomCard(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle),
                                child: Image.network(
                                    "${Api.imageBaseUrl}${qrData.image}"),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              _buildDataRow('ID:', qrData.id.toString()),
                              _buildDataRow('CNIC:', qrData.cnic ?? ""),
                              _buildDataRow(
                                  'Vehicle No:', qrData.vehicleNo ?? ""),
                              _buildDataRow(
                                  'Visitor Type:', qrData.visitorType ?? ""),
                              _buildDataRow('Name:', qrData.name ?? ""),
                              _buildDataRow('Mobile:', qrData.mobile ?? ""),
                              _buildDataRow(
                                  'Description:', qrData.description ?? ""),
                              SizedBox(
                                height: 40,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyButton(
                                      width: 120,
                                      gradient: AppGradients.buttonGradient,
                                      name: "Cancel",
                                      onPressed: () {
                                        Get.offNamed(homescreen,
                                            arguments:
                                                qrEntryController.userdata);
                                      },
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Obx(() => MyButton(
                                          width: 120,
                                          loading:
                                              qrEntryController.isLoading.value,
                                          gradient: AppGradients.buttonGradient,
                                          name: "Done",
                                          onPressed: () {
                                            qrEntryController
                                                .updatePreApproveEntryStatusApi(
                                              id: qrData.id!,
                                              status: 2,
                                              statusdescription: 'CheckIn',
                                              cnic: qrData.cnic ?? "",
                                              vechileno: qrData.vehicleNo ?? "",
                                            );
                                          },
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildDataRow(String label, String data) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Expanded(
          child: Text(
            data,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    ),
  );
}
