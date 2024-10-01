import 'package:flutter/material.dart';
import 'package:gatekeeper/Module/ResidentQrEntryExit/model/checkedin_residents_model.dart';
import 'package:gatekeeper/Module/ResidentQrEntryExit/model/update_resident_entry_model.dart';
import 'package:gatekeeper/Module/ResidentQrEntryExit/service/resident_entry_service.dart';
import 'package:gatekeeper/Module/ResidentQrEntryExit/view/all_resident_reocords.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../Login/Model/User.dart';

class ResidentQrEntryController extends GetxController {
  var data = Get.arguments;
  late final User userdata;
  List<Datum> residentRecordList = [];

  RxString error = "".obs;
  var allResidentRec = CheckedInResidentModel();
  RxString searchValue = "".obs;
  var pageSize = 6;
  final PagingController<int, Datum> pagingController =
      PagingController(firstPageKey: 1);

  /////// UPDATE RESIDENT ENTRY EXIT STATUS
  var residentEntryStatusModel = UpdateResidentEntryModel();
  RxString error1 = "".obs;
  RxBool loading = false.obs;
  RxBool refreshLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    userdata = data;

    pagingController.addPageRequestListener((pageKey) {
      allCheckedInResident(
          status: "",
          visitorType: "resident",
          societyId: userdata.societyid.toString(),
          pageKey: pageKey,
          limit: pageSize);
    });
  }

  Future<void> allCheckedInResident({
    String? status,
    String? societyId,
    String? visitorType,
    int? pageKey,
    int? limit,
  }) async {
    print("this method call");
    error.value = "";

    var res = await ResidentEntryService.allCheckedInResident(
      societyId: societyId,
      status: status,
      visitorType: visitorType,
      pageKey: pageKey,
      limit: limit,
    );

    if (res is CheckedInResidentModel) {
      allResidentRec = res;
      residentRecordList = allResidentRec.data?.data ?? [];

      final isLastPage = residentRecordList.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(residentRecordList);
      } else {
        final nextPageKey = pageKey! + 1;
        pagingController.appendPage(residentRecordList, nextPageKey);
      }
    } else {
      error.value = res.toString();
      Get.snackbar("Error", error.value);
    }
  }

//////  METHOD FOR PAGINATION

  void updateResidentEntryStatus(
      {int? societyId,
      int? residentId,
      int? gatekeeperId,
      int? subadminid,
      BuildContext? context}) async {
    print("resident qr scan method call");
    loading.value = true;
    error1.value = "";

    var res = await ResidentEntryService.updateResidentEntryStatus(
        societyId: societyId,
        residentId: residentId,
        gatekeeperId: gatekeeperId,
        subadminid: subadminid);
    loading.value = false;
    if (res is UpdateResidentEntryModel) {
      residentEntryStatusModel = res;
      Navigator.of(context!).pop();
      Get.snackbar("Message", residentEntryStatusModel.message.toString());

      Get.offAll(AllResidentRecord(), arguments: userdata);
      //  Get.offNamed(residentRecords, arguments: userdata);
    } else {
      loading.value = false;
      error1.value = res.toString();
      Get.snackbar("Error", error1.value);
    }
  }
}
