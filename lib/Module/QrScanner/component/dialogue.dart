import 'package:flutter/material.dart';
import 'package:gatekeeper/Module/Pre%20Approved%20Guests/Controller/pre_approve_entries_controller.dart';
import 'package:gatekeeper/Module/QrScanner/model/qr_data_model.dart';
import 'package:gatekeeper/Module/ResidentQrEntryExit/controller/resident_qr_entry_exit_controller.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:get/get.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

void showScannedDataDialogForResident(
  QrData qrData,
  BuildContext context,
  QRViewController? qrcontrolle,
  ResidentQrEntryController controller,
) {
  // var preApprovedEntryController = Get.put(PreApproveEntriesController());
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Scanned QR Data',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              _buildDataRow('Type:', qrData.type ?? ""),
              _buildDataRow('User ID:', qrData.userId.toString()),
              _buildDataRow('Resident ID:', qrData.residentId.toString()),
              _buildDataRow('Name:', '${qrData.firstName} ${qrData.lastName}'),
              _buildDataRow('Address:', qrData.address ?? ""),
              _buildDataRow('Mobile:', qrData.mobile ?? ""),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red, // Cancel button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                )),
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); // Pop the dialog first
              Navigator.of(context).pop(); // Pop the second time
              qrcontrolle?.resumeCamera();
            },
          ),
          Obx(() => controller.loading.value
              ? SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: AppColors.appThem,
                  ),
                )
              : TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green, // Done button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      )),
                  child: Text('Done'),
                  onPressed: () {
                    qrcontrolle?.resumeCamera();
                    controller.updateResidentEntryStatus(
                        societyId: controller.userdata.societyid,
                        residentId: qrData.residentId,
                        gatekeeperId: controller.userdata.userid,
                        subadminid: controller.userdata.subadminid,
                        context: context);
                  },
                )),
        ],
      );
    },
  );
}

void showScannedDataDialogForPreApproved(
  QrData qrData,
  BuildContext context,
  QRViewController? qrcontrolle,
) {
  var preApprovedEntryController = Get.put(PreApproveEntriesController());
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Scanned QR Data',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              _buildDataRow('Type:', qrData.type ?? ""),
              _buildDataRow('ID:', qrData.id.toString()),
              _buildDataRow('CNIC:', qrData.cnic ?? ""),
              _buildDataRow('Vehicle No:', qrData.vehicleNo ?? ""),
              _buildDataRow('Visitor Type:', qrData.visitorType ?? ""),
              _buildDataRow('Name:', qrData.name ?? ""),
              _buildDataRow('Mobile:', qrData.mobile ?? ""),
              _buildDataRow('Description:', qrData.description ?? ""),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red, // Cancel button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                )),
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); // Pop the dialog first
              Navigator.of(context).pop(); // Pop the second time
              qrcontrolle?.resumeCamera();
            },
          ),
          Obx(() => preApprovedEntryController.isLoading.value
              ? SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: AppColors.appThem,
                  ))
              : TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green, // Done button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      )),
                  child: Text('Done'),
                  onPressed: () {
                     qrcontrolle?.resumeCamera();
                    preApprovedEntryController.updatePreApproveEntryStatusApi(
                        id: qrData.id!,
                        status: 2,
                        statusdescription: 'CheckIn',
                        cnic: qrData.cnic ?? "",
                        vechileno: qrData.vehicleNo ?? "",
                        context: context);
                   
                   
                  },
                )),
        ],
      );
    },
  );
}

// Helper method to build a row with a bold label and normal data
Widget _buildDataRow(String label, String data) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
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
