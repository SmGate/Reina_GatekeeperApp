import 'package:flutter/material.dart';
import 'package:gatekeeper/Module/Vistor%20Detail/Model/update_visitor_detail.model.dart';
import 'package:gatekeeper/Module/Vistor%20Detail/Model/visitor_detail_model.dart';
import 'package:gatekeeper/Module/Vistor%20Detail/service/visitor_detail_service.dart';
import 'package:gatekeeper/utils/Constants/constants.dart';
import 'package:get/get.dart';
import '../../Login/Model/User.dart';

class VisitorDetailController extends GetxController {
  late final User userdata;

  var data = Get.arguments;
  DateTime currentDateTime = DateTime.now();
  String? currentDate;
  String? currentTime;
  var status = Status.completed;
  RxBool isLoading = false.obs;

  var visitorDetailsModel = VisitorDetailModel();
  var error = "";

  var updateVisitorDetailModel = UpdateVisitorDetailModel();
  var errorUpdatingVisitorsDetails = "";

  @override
  void onInit() {
    super.onInit();

    userdata = data;
  }

  Future<VisitorDetailModel> getVisitorDetails({
    required int societyId,
  }) async {
    error = "";
    var res = await VisitorDetailService.visitorDetail(societyId: societyId);
    if (res is VisitorDetailModel) {
      visitorDetailsModel = res;
      return visitorDetailsModel;
    } else {
      error = res.toString();
      Get.snackbar("Error", error);
    }

    return visitorDetailsModel;
  }

  Future updateVisitorDetailApi(
      {required int vid,
      required String checkoutdate,
      required String checkouttime,
      BuildContext? context}) async {
    errorUpdatingVisitorsDetails = "";
    isLoading.value = true;

    var res = await VisitorDetailService.updateVisitorDetail(
        vid: vid, checkoutdate: checkoutdate, checkouttime: checkouttime);
    isLoading.value = false;
    if (res is UpdateVisitorDetailModel) {
      updateVisitorDetailModel = res;
      if (context != null) {
        Navigator.pop(context); // Close the dialog box
      }
    } else {
      isLoading.value = false;
      errorUpdatingVisitorsDetails = res.toString();
      Get.snackbar("Error", errorUpdatingVisitorsDetails);
    }
  }
}
