import 'package:gatekeeper/Module/Pre%20Approve%20Entry%20Residents/Model/pre_approved_entry_model.dart';
import 'package:gatekeeper/Module/Pre%20Approve%20Entry%20Residents/service/pre_approved_entry_service.dart';
import 'package:get/get.dart';
import '../../Login/Model/User.dart';

class PreApproveEntryResdientsController extends GetxController {
  var user = Get.arguments;

  late final User userdata;

  @override
  void onInit() {
    super.onInit();
    print("init");
    userdata = this.user;
  }

  var error = "";
  var preApprovedEntryModel = PreApprovedEntryModel();

  Future<PreApprovedEntryModel> preApproveEntryResident({
    int? userid,
  }) async {
    error = "";
    var res = await PreApprovedEntryService.preApprovedEntry(userid: userid);
    if (res is PreApprovedEntryModel) {
      preApprovedEntryModel = res;
      return preApprovedEntryModel;
    } else {
      error = res.toString();
      Get.snackbar("Error", error);
    }
    return preApprovedEntryModel;
  }
}
