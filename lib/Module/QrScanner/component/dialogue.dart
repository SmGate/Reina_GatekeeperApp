import 'package:flutter/material.dart';
import 'package:gatekeeper/Module/QrScanner/controller/qr_entry_controller.dart';
import 'package:gatekeeper/Module/QrScanner/model/qr_data_model.dart';
import 'package:gatekeeper/utils/Constants/api_routes.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:get/get.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

void showScannedDataDialogForResident(QrData qrData, BuildContext context,
    QRViewController? qrcontrolle, QrEntryController qrEntryController) {
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
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Image.network("${Api.imageBaseUrl}${qrData.image}"),
              ),
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
          Obx(() => qrEntryController.loading.value
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
                    qrEntryController.updateResidentEntryStatus(
                      societyId: qrEntryController.userdata.societyid,
                      residentId: qrData.residentId,
                      gatekeeperId: qrEntryController.userdata.userid,
                      subadminid: qrEntryController.userdata.subadminid,
                    );
                  },
                )),
        ],
      );
    },
  );
}

void showScannedDataDialogForPreApproved(
    {int? id,
    String? cnic,
    String? vehicleNo,
    String? visitorType,
    String? description,
    String? name,
    String? mobile,
    String? image,
    BuildContext? context,
    QRViewController? qrcontrolle,
    QrEntryController? qrEntryController}) {
  showDialog(
    context: context!,
    builder: (context) {
      return AlertDialog(
        title: Text('Scanned QR Data',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Image.network("${Api.imageBaseUrl}${image}"),
              ),
              _buildDataRow('ID:', id.toString()),
              _buildDataRow('CNIC:', cnic ?? ""),
              _buildDataRow('Vehicle No:', vehicleNo ?? ""),
              _buildDataRow('Visitor Type:', visitorType ?? ""),
              _buildDataRow('Name:', name ?? ""),
              _buildDataRow('Mobile:', mobile ?? ""),
              _buildDataRow('Description:', description ?? ""),
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
          Obx(() => qrEntryController!.isLoading.value
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
                    qrEntryController.updatePreApproveEntryStatusApi(
                      id: id!,
                      status: 2,
                      statusdescription: 'CheckIn',
                      cnic: cnic ?? "",
                      vechileno: vehicleNo ?? "",
                    );
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
