import 'package:gatekeeper/Module/Residental%20Emergency/Model/residential_emergency_model.dart';
import 'package:gatekeeper/Module/Residental%20Emergency/service/residential_emergency_service.dart';
import 'package:get/get.dart';
import '../../Login/Model/User.dart';

class ResidentialEmergencyController extends GetxController {
  late final User userdata;

  Uri? uri;
  var data = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    userdata = data;
  }

  var error = "";
  var residentialEmergencyModel = ResidentialEmergencyModel();

  Future<ResidentialEmergencyModel> residentialEmergency({
    int? subadminid,
  }) async {
    error = "";
    var res = await ResidentialEmergencyService.residentialEmergencies(
        subadminid: subadminid);
    if (res is ResidentialEmergencyModel) {
      residentialEmergencyModel = res;

      return residentialEmergencyModel;
    } else {
      error = res.toString();
      Get.snackbar("Error", error);
    }

    return residentialEmergencyModel;
  }
}
