import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gatekeeper/Module/Pre%20Approved%20Guests/Controller/pre_approve_entries_controller.dart';
import 'package:gatekeeper/utils/Constants/api_routes.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:gatekeeper/utils/styles/text_style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanner extends StatefulWidget {
  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  var preApprovedEntryController = Get.find<PreApproveEntriesController>();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isDialogShown = false; // Flag to control dialog display
  Map<String, dynamic>? scannedData;
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Code Scanner')),
      body: QRView(
        overlay: QrScannerOverlayShape(borderColor: AppColors.globalWhite),
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) async {
      if (scanData.code == null || scanData.code!.isEmpty) {
        Get.snackbar("Error", "Scanned data is empty.");
        return;
      }

      if (isDialogShown) {
        return;
      }

      try {
        // Save scanned data
        scannedData = jsonDecode(scanData.code!);
        print("Scan data is  $scannedData");

        isDialogShown = true;
        controller.dispose();
        await _showDialogWithScannedData(scannedData!);
      } catch (e) {
        print('Parsing error: $e');
        Get.snackbar("Error", "Failed to parse scanned data: ${e.toString()}");
      }
    });
  }

  Future<void> _showDialogWithScannedData(Map<String, dynamic> data) async {
    // Extract data
    int id = data['id'];
    String? cnic = data['cnic'] ?? "";
    String? vehicleNo = data['vechileno'] ?? "";
    String? visitorType = data['visitortype'] ?? "";
    String? description = data['description'] ?? "";
    String? mobile = data['mobileno'] ?? "";
    String? image = data['image'] ?? "";
    String? name = data['name'] ?? "";

    // Show dialog
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Scanned Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (image != null && image.isNotEmpty)
                Container(
                    margin: EdgeInsets.all(20),
                    height: 200,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: "${Api.imageBaseUrl}${image}",
                      placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                        color: AppColors.appThem,
                      )),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                    )),
              SizedBox(
                height: 20,
              ),
              QrText(text1: "Name", text2: name),
              QrText(text1: "CNIC", text2: cnic),
              QrText(text1: "Vehicle Number", text2: vehicleNo),
              QrText(text1: "Visitor Type", text2: visitorType),
              QrText(text1: "Description", text2: description),
              QrText(text1: "Mobile No", text2: mobile),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(() => preApprovedEntryController.isLoading.value
                      ? SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            color: AppColors.appThem,
                          ))
                      : ElevatedButton(
                          child: Text("Done"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          onPressed: () async {
                            await preApprovedEntryController
                                .updatePreApproveEntryStatusApi(
                                    id: id,
                                    status: 2,
                                    statusdescription: 'CheckIn',
                                    cnic: cnic ?? "",
                                    vechileno: vehicleNo ?? "",
                                    context: context);

                            isDialogShown = false;
                          },
                        )),
                  ElevatedButton(
                    child: Text("Cancel"),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () async {
                      Navigator.of(context).pop(); // Pop the first screen
                      Navigator.of(context).pop();
                    },
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget QrText({
    String? text1,
    String? text2,
  }) {
    return Column(
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
}
