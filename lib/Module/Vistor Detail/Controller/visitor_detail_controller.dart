import 'package:flutter/material.dart';
import 'package:gatekeeper/Module/Vistor%20Detail/Model/update_visitor_detail.model.dart';
import 'package:gatekeeper/Module/Vistor%20Detail/Model/visitor_detail_model.dart';
import 'package:gatekeeper/Module/Vistor%20Detail/service/visitor_detail_service.dart';
import 'package:gatekeeper/utils/Constants/constants.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../Login/Model/User.dart';

class VisitorDetailController extends GetxController {
  late final User userdata;

  var data = Get.arguments;
  DateTime currentDateTime = DateTime.now();
  String? currentDate;
  String? currentTime;
  var status = Status.completed;
  RxBool isLoading = false.obs;
  RxString searchValue = "".obs;
  var visitorDetailsModel = VisitorDetailModel();
  var error = "";

  var updateVisitorDetailModel = UpdateVisitorDetailModel();
  var errorUpdatingVisitorsDetails = "";

  List<Datum> dataList = [];
  var pageSize = 10;
  final PagingController<int, Datum> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    super.onInit();

    userdata = data;

    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(
          societyId: userdata.societyid!, pageKey: pageKey, limit: pageSize);
    });
  }

  Future<List<Datum>> getVisitorDetails({
    required int societyId,
    int? pageKey,
    int? limit,
  }) async {
    error = "";

    var res = await VisitorDetailService.visitorDetail(
        societyId: societyId, pageKey: pageKey, limit: limit);

    if (res is VisitorDetailModel) {
      visitorDetailsModel = res;

      List<Datum> newVisitors = res.data?.data ?? [];

      return newVisitors;
    } else {
      error = res.toString();
      Get.snackbar("Error", error);
    }

    return [];
  }

  Future updateVisitorDetailApi(
      {required int vid,
      required String checkoutdate,
      required String checkouttime,
      BuildContext? context}) async {
    errorUpdatingVisitorsDetails = "";

    var res = await VisitorDetailService.updateVisitorDetail(
        vid: vid, checkoutdate: checkoutdate, checkouttime: checkouttime);

    if (res is UpdateVisitorDetailModel) {
      updateVisitorDetailModel = res;
      if (context != null) {
        Navigator.pop(context); // Close the dialog box
      }
    } else {
      errorUpdatingVisitorsDetails = res.toString();
      Get.snackbar("Error", errorUpdatingVisitorsDetails);
    }
  }

  Future<void> _fetchPage({
    required int societyId,
    int? pageKey,
    int? limit,
  }) async {
    dataList = await getVisitorDetails(
        pageKey: pageKey, societyId: societyId, limit: limit);

    final isLastPage = dataList.length < pageSize;
    if (isLastPage) {
      pagingController.appendLastPage(dataList);
    } else {
      final nextPageKey = pageKey! + 1;
      pagingController.appendPage(dataList, nextPageKey);
    }
  }
}
