import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gatekeeper/Module/Pre%20Approved%20Guests/model/pre_approved_guest_model.dart';
import 'package:gatekeeper/Module/Pre%20Approved%20Guests/model/update_pre_approved_entry_status.dart';
import 'package:gatekeeper/Module/Pre%20Approved%20Guests/service/pre_approved_guest_service.dart';
import 'package:gatekeeper/utils/Constants/api_routes.dart';
import 'package:gatekeeper/utils/Constants/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;

class PreApproveEntriesController extends GetxController {
  final cnicController = TextEditingController();
  final vechilenoController = TextEditingController();

  var data = Get.arguments[0];
  var token = Get.arguments[1];
  var status = Status.completed;
  RxBool isLoading = false.obs;

  var error = "";
  var preApprovedGuestModel = PreApprovedGuestModel();

  var errorUpdatingStatus = "";
  var updatePreApprovedStatusModel = UpdatePreApprovedEntryStatusModel();
  @override
  void onInit() {
    super.onInit();
  }

  Future<PreApprovedGuestModel> preApproveGuest({
    int? userid,
  }) async {
    error = "";
    var res = await PreApprovedGuestService.preApprovedGuest(userid: userid);
    if (res is PreApprovedGuestModel) {
      preApprovedGuestModel = res;
      return preApprovedGuestModel;
    } else {
      error = res.toString();
      Get.snackbar("Error", error);
    }
    return preApprovedGuestModel;
  }

  Future updatePreApproveEntryStatusApi(
      {required int id,
      required int status,
      required String statusdescription,
      required String cnic,
      required String vechileno,
      BuildContext? context}) async {
    isLoading.value = true;
    errorUpdatingStatus = "";

    var res = await PreApprovedGuestService.updatePreApprovedEntryStatus(
        id: id,
        status: status,
        statusdescription: statusdescription,
        cnic: cnic,
        vechileno: vechileno);
    isLoading.value = false;
    if (res is UpdatePreApprovedEntryStatusModel) {
      updatePreApprovedStatusModel = res;

      Get.snackbar("Message", updatePreApprovedStatusModel.message.toString());
      Navigator.of(context!).pop();
      Navigator.of(context).pop();
    } else {
      errorUpdatingStatus = res.toString();
      Get.snackbar("Error", errorUpdatingStatus);
    }
  }

  Future updatePreapproveEntryCheckoutStatusApi({
    required int id,
    required String token,
    required int status,
    required String statusdescription,
  }) async {
    setStatus(Status.loading);

    final response = await Http.post(
      Uri.parse(Api.updatepreapproveentrycheckoutstatus),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(<String, dynamic>{
        "id": id,
        "status": status,
        "statusdescription": statusdescription,
      }),
    );

    if (response.statusCode == 200) {
      setStatus(Status.completed);

      update();

      myToast(msg: 'Checkout Successfully');
    } else {
      setStatus(Status.error);
      myToast(msg: 'Failed to Checkout status', isNegative: true);
      throw Exception();
    }
  }

  setStatus(Status status) {
    this.status = status;
    update();
  }

  isCheckInStatus(val) {
    this.isLoading = val;
    update();
  }
}
