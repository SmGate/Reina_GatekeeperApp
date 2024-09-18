import 'package:gatekeeper/Module/Events/Model/all_events-model.dart';
import 'package:gatekeeper/Module/Events/service/all_events_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../Login/Model/User.dart';

class EventScreenController extends GetxController {
  final ImagePicker imagePicker = ImagePicker();
  var user = Get.arguments;
  late final User userdata;

  var allEventsModel = AllEventsModel();
  var error = "";

  @override
  void onInit() {
    super.onInit();
    userdata = user;
  }

  Future<AllEventsModel> allEvents({
    required int userid,
  }) async {
    error = "";
    var res = await AllEventsService.getAllEvents(userId: userid);
    if (res is AllEventsModel) {
      allEventsModel = res;
      return allEventsModel;
    } else {
      error = res.toString();
      Get.snackbar("Error", error);
    }

    return allEventsModel;
  }
}
