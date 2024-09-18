import 'dart:convert';

import 'package:gatekeeper/utils/Constants/api_routes.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import '../../../Routes/set_routes.dart';
import '../../../Services/Notification Services/notification_services.dart';
import '../../../Services/Shared Preferences/MySharedPreferences.dart';
import '../../Login/Model/User.dart';

class HomeScreenController extends GetxController {
  late final User user;
  var argument = Get.arguments;
  int count = 0;

  @override
  void onInit() {
    super.onInit();
    NotificationServices notificationServices = NotificationServices();
    notificationServices.requestNotification();
    notificationServices.fireBaseInit();
    notificationServices.setupInteractMessage();
    notificationServices.getDeviceToken();
    user = argument;
  }

  logoutApi({required String token}) async {
    print(token);

    final response = await Http.post(
      Uri.parse(Api.logout),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );
    print(response.body);
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      print("logout successfully");

      MySharedPreferences.deleteUserData();

      Get.offAllNamed(loginscreen);
    } else {
      print(data);
    }
  }
}
