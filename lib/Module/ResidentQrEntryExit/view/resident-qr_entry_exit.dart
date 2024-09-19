// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gatekeeper/utils/Constants/api_routes.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:gatekeeper/utils/styles/text_style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ResidentQrEntryExit extends StatefulWidget {
  @override
  _ResidentQrEntryExitState createState() => _ResidentQrEntryExitState();
}

class _ResidentQrEntryExitState extends State<ResidentQrEntryExit> {
  //var preApprovedEntryController = Get.find<PreApproveEntriesController>();
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
    try {
      // Extracting data into individual variables
      int? userId = data['userId'] as int?;
      String? firstName = data['firstName'] as String?;
      String? lastName = data['lastName'] as String?;
      String? address = data['address'] as String?;
      String? roleName = data['roleName'] as String?;
      String? mobile = data['mobile'] as String?;
      String? image = data['image'] as String?;

      // Display the extracted data in the dialog
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Resident Information'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (image != null && image.isNotEmpty)
                    Container(
                      margin: EdgeInsets.all(20),
                      height: 60,
                      width: 60,
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
                  QrText(text1: "Id", text2: userId.toString()),
                  QrText(text1: "Name", text2: "$firstName $lastName"),
                  QrText(text1: "Mobile", text2: mobile ?? ""),
                  QrText(text1: "Role", text2: roleName ?? ""),
                  QrText(text1: "Address", text2: address ?? ""),
                  SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch scanned data: ${e.toString()}");
    }
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
