// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gatekeeper/Module/ResidentQrEntryExit/controller/resident_qr_entry_exit_controller.dart';

import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../component/dialogue.dart';
import '../model/qr_data_model.dart';

class ScanQrCodeScreen extends StatefulWidget {
  @override
  _ScanQrCodeScreenState createState() => _ScanQrCodeScreenState();
}

class _ScanQrCodeScreenState extends State<ScanQrCodeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  late StreamSubscription<Barcode> scanSubscription;

  Map<String, dynamic>? scannedData;
  var residentQrEntryController = Get.put(ResidentQrEntryController());

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

      try {
        // Save scanned data
        scannedData = jsonDecode(scanData.code!);
        print("Scan data is: $scannedData");

        controller.pauseCamera();

        Map<String, dynamic> data = scannedData!;

        QrData qrData;

        // Check if it is a resident QR code
        if (data.containsKey('userId') && data.containsKey('residentid')) {
          qrData = QrData.resident(
            type: scannedData?['userType'] as String?,
            userId: data['userId'] as int?,
            residentId: data['residentid'] as int?,
            firstName: data['firstName'] as String?,
            lastName: data['lastName'] as String?,
            address: data['address'] as String?,
            roleName: data['roleName'] as String?,
            mobile: data['mobile'] as String?,
            image: data['image'] as String?,
          );
        } else if (data.containsKey('id') && data.containsKey('cnic')) {
          qrData = QrData.preApproved(
            type: 'pre-approved',
            id: data['id'] ?? 0,
            cnic: data['cnic'] ?? "",
            vehicleNo: data['vechileno'] ?? "",
            visitorType: data['visitortype'] ?? "",
            description: data['description'] ?? "",
            mobile: data['mobileno'] ?? "",
            image: data['image'] ?? "",
            name: data['name'] ?? "",
          );
        } else {
          // Handle unexpected QR structure
          Get.snackbar("Error", "Unknown QR code format.");
          return;
        }

        // Get.to(() => ScaneedDataDetails(
        //       qrData: qrData,
        //     ));
        qrData.type == "resident"
            ? showScannedDataDialogForResident(
                qrData,
                context,
                controller,
                residentQrEntryController,
              )
            : showScannedDataDialogForPreApproved(
                qrData,
                context,
                controller,
              );
        controller.dispose();
      } catch (e) {
        print('Parsing error: $e');
        Get.snackbar("Error", "Failed to parse scanned data: ${e.toString()}");
      }
    });
  }

  /////////////////////
}
