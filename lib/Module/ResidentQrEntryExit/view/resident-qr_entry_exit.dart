// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gatekeeper/Module/ResidentQrEntryExit/controller/resident_qr_entry_exit_controller.dart';
import 'package:gatekeeper/Module/ResidentQrEntryExit/view/qr_details_screen.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ResidentQrEntryExit extends StatefulWidget {
  @override
  _ResidentQrEntryExitState createState() => _ResidentQrEntryExitState();
}

class _ResidentQrEntryExitState extends State<ResidentQrEntryExit> {
  final ResidentQrEntryController residentController =
      Get.find<ResidentQrEntryController>();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  late StreamSubscription<Barcode> scanSubscription;
  bool isDialogShown = false;
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
    scanSubscription.cancel(); // Cancel the subscription
    controller?.dispose(); // Dispose the controller
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

    scanSubscription = controller.scannedDataStream.listen((scanData) async {
      if (scanData.code == null || scanData.code!.isEmpty) {
        Get.snackbar("Error", "Scanned data is empty.");
        return;
      }

      if (isDialogShown) return;

      try {
        // Save scanned data
        scannedData = jsonDecode(scanData.code!);
        print("Scan data is: $scannedData");

        isDialogShown = true;
        controller.pauseCamera(); // Pause the camera before showing the dialog
        await _showDialogWithScannedData(scannedData!);
      } catch (e) {
        print('Parsing error: $e');
        Get.snackbar("Error", "Failed to parse scanned data: ${e.toString()}");
      } finally {
        // Don't dispose the controller here
      }
    });
  }

  Future<void> _showDialogWithScannedData(Map<String, dynamic> data) async {
    try {
      // Extracting data into individual variables
      int? userId = data['userId'] as int?;
      int? residentId = data['residentid'] as int?;
      String? firstName = data['firstName'] as String?;
      String? lastName = data['lastName'] as String?;
      String? address = data['address'] as String?;
      String? roleName = data['roleName'] as String?;
      String? mobile = data['mobile'] as String?;
      String? image = data['image'] as String?;

      // Navigate to the QrDetailsScreen
      Get.to(() => QrDetailsScreen(
            userId: residentId,
            firstName: firstName,
            lastName: lastName,
            address: address,
            roleName: roleName,
            mobile: mobile,
            image: image,
          ));

      // After navigating, set the dialog shown flag back to false
      isDialogShown = false;
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch scanned data: ${e.toString()}");
    }
  }
}
