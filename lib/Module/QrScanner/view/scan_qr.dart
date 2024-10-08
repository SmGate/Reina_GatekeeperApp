// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gatekeeper/Module/QrScanner/controller/qr_entry_controller.dart';
import 'package:gatekeeper/Module/QrScanner/view/qr_details.dart';

import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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
  var qrEntryController = Get.find<QrEntryController>();
  bool isCameraPaused = false; // Add this flag
  @override
  void reassemble() {
    super.reassemble();
    if (!isCameraPaused) {
      // Only resume if the camera is not paused
      if (Platform.isAndroid) {
        controller?.pauseCamera();
      }
      controller?.resumeCamera();
    }
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

      try {
        // Save scanned data
        var decodedData = jsonDecode(scanData.code!);
        print(
            "Decoded scan data is: $decodedData (${decodedData.runtimeType})");

        if (decodedData is Map<String, dynamic>) {
          Map<String, dynamic> data = decodedData;

          QrData qrData;

          // Check if it is a resident QR code
          if (data.containsKey('userId') && data.containsKey('residentid')) {
            qrData = QrData.resident(
              type: "resident",
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
              cnic: data['cnic'] as String?,
              vehicleNo: data['vechileno'] as String?,
              visitorType: data['visitortype'] as String?,
              description: data['description'] as String?,
              mobile: data['mobileno'] as String?,
              image: data['image'] as String?,
              name: data['name'] as String?,
            );
          } else {
            // Handle unexpected QR structure
            Get.snackbar("Error", "Unknown QR code format.");
            return;
          }

          await controller.pauseCamera();
          isCameraPaused = true; // Mark the camera as paused
          scanSubscription.cancel();
          controller.dispose();

          Get.to(QrDetailsScreen(qrData: qrData, qrcontrolle: controller));
        } else {
          print("Scanned data is not in expected format.");
          Get.snackbar("Error", "Scanned data is not in expected format.");
        }

        controller.dispose();
      } catch (e) {
        print('Parsing error: $e');
        Get.snackbar("Error", "Failed to parse scanned data: ${e.toString()}");
      }
    });
  }

  /////////////////////
}
