import 'package:flutter/material.dart';
import 'package:gatekeeper/Module/ResidentQrEntryExit/model/checkedin_residents_model.dart';
import 'package:gatekeeper/Module/ResidentQrEntryExit/model/update_resident_entry_model.dart';
import 'package:gatekeeper/Module/ResidentQrEntryExit/service/resident_entry_service.dart';
import 'package:gatekeeper/Routes/set_routes.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../Login/Model/User.dart';

class ResidentQrEntryController extends GetxController {
  var data = Get.arguments;
  late final User userdata;
  List<Datum> residentRecordList = [];
  List<Datum> dataList = [];
  RxString error = "".obs;
  var allResidentRec = CheckedInResidentModel();

  static const pageSize = 10;
  final PagingController<int, Datum> pagingController =
      PagingController(firstPageKey: 1);

  /////// UPDATE RESIDENT ENTRY EXIT STATUS
  var residentEntryStatusModel = UpdateResidentEntryModel();
  RxString error1 = "".obs;
  RxBool loading = false.obs;
  @override
  void onInit() {
    super.onInit();
    userdata = data;

    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(
          status: "",
          visitorType: "",
          societyId: userdata.societyid.toString(),
          pageKey: pageKey,
          limit: pageSize);
    });
  }

  Future<List<Datum>> allCheckedInResident(
      {String? status,
      String? societyId,
      String? visitorType,
      int? pageKey,
      int? limit}) async {
    error.value = "";

    var res = await ResidentEntryService.allCheckedInResident(
        societyId: societyId,
        status: status,
        visitorType: visitorType,
        pageKey: pageKey,
        limit: limit);

    if (res is CheckedInResidentModel) {
      allResidentRec = res;

      residentRecordList = allResidentRec.data?.data ?? [];

      return residentRecordList;
    } else {
      error.value = res.toString();
      Get.snackbar("Error", error.value);
    }
    return residentRecordList;
  }

//////  METHOD FOR PAGINATION
  Future<void> _fetchPage(
      {String? status,
      String? societyId,
      String? visitorType,
      int? pageKey,
      int? limit}) async {
    dataList = await allCheckedInResident(
        societyId: societyId,
        status: status,
        visitorType: visitorType,
        pageKey: pageKey,
        limit: limit);

    final isLastPage = dataList.length < pageSize;
    if (isLastPage) {
      pagingController.appendLastPage(dataList);
    } else {
      final nextPageKey = pageKey! + 1;
      pagingController.appendPage(dataList, nextPageKey);
    }
  }

  void updateResidentEntryStatus(
      {int? societyId,
      int? residentId,
      int? gatekeeperId,
      int? subadminid,
      BuildContext? context}) async {
    loading.value = true;
    error1.value = "";

    var res = await ResidentEntryService.updateResidentEntryStatus(
        societyId: societyId,
        residentId: residentId,
        gatekeeperId: gatekeeperId,
        subadminid: subadminid);

    if (res is UpdateResidentEntryModel) {
      residentEntryStatusModel = res;

      Navigator.of(context!).pop();
      Get.snackbar("Message", residentEntryStatusModel.message.toString());

      Get.offAll(homescreen, arguments: userdata);
    } else {
      loading.value = false;
      error1.value = res.toString();
      Get.snackbar("Error", error1.value);
    }
  }
}
