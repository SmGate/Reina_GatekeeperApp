import 'package:gatekeeper/Module/Pre%20Approved%20Guests/model/update_pre_approved_entry_status.dart';
import 'package:gatekeeper/Module/Pre%20Approved%20Guests/service/pre_approved_guest_service.dart';
import 'package:gatekeeper/Module/ResidentQrEntryExit/service/resident_entry_service.dart';

import 'package:gatekeeper/Routes/set_routes.dart';
import 'package:get/get.dart';

import '../../Login/Model/User.dart';
import '../../ResidentQrEntryExit/model/update_resident_entry_model.dart';

class QrEntryController extends GetxController {
  var data = Get.arguments;
  late final User userdata;

  var errorUpdatingStatus = "";
  var updatePreApprovedStatusModel = UpdatePreApprovedEntryStatusModel();
  RxBool isLoading = false.obs;

  /////// UPDATE RESIDENT ENTRY EXIT STATUS
  var residentEntryStatusModel = UpdateResidentEntryModel();
  RxString error1 = "".obs;
  RxBool loading = false.obs;
  RxBool refreshLoading = false.obs;

  void onInit() {
    super.onInit();
    userdata = data;
  }

  Future updatePreApproveEntryStatusApi({
    required int id,
    required int status,
    required String statusdescription,
    required String cnic,
    required String vechileno,
  }) async {
    print("pre approved qr scan method call");
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
      Get.offNamed(preApproveEntryResidents, arguments: userdata);
    } else {
      errorUpdatingStatus = res.toString();
      Get.snackbar("Error", errorUpdatingStatus);
    }
  }

  /////////////////////

  void updateResidentEntryStatus({
    int? societyId,
    int? residentId,
    int? gatekeeperId,
    int? subadminid,
  }) async {
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

      Get.snackbar("Message", residentEntryStatusModel.message.toString());
      // Get.offAll(AllResidentRecord(), arguments: userdata);
      Get.offNamed(residentRecords, arguments: userdata);
    } else {
      loading.value = false;
      error1.value = res.toString();
      Get.snackbar("Error", error1.value);
    }
  }
}
