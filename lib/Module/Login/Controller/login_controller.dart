import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gatekeeper/Module/Login/Model/login_user_model.dart';
import 'package:gatekeeper/Module/Login/service/login_service.dart';
import 'package:gatekeeper/Routes/set_routes.dart';
import 'package:gatekeeper/utils/Constants/constants.dart';
import 'package:gatekeeper/utils/Constants/session_controller.dart';
import 'package:get/get.dart';
import '../../../Services/Shared Preferences/MySharedPreferences.dart';
import '../Model/User.dart';

class LoginController extends GetxController {
  var isHidden = false;
  var isLoading = false;

  TextEditingController userCnicController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  var userModel = LoginUserModel();
  RxBool loadingLoginUser = false.obs;
  RxString error = "".obs;

  void loginUser({String? cnic, String? password}) async {
    error.value = "";
    loadingLoginUser.value = true;

    var res = await LoginService.loginUser(cnic: cnic, password: password);

    if (res.success == true && res.data?.rolename == "gatekeeper") {
      userModel = res;

      final User user = User(
          userid: userModel.data?.gatekeeperid,
          subadminid: userModel.data?.subadminid,
          societyid: userModel.data?.societyid,
          firstName: userModel.data?.firstname,
          lastName: userModel.data?.lastname,
          cnic: userModel.data?.cnic,
          roleId: userModel.data?.roleid,
          roleName: userModel.data?.rolename,
          bearerToken: userModel.bearer);

      MySharedPreferences.setUserData(user: user);
      SessionController().bearerToken = user.bearerToken ?? "";
      FirebaseMessaging.instance.getToken().then((value) {
        String? token = value;
        fcmtokenrefresh(user.userid!, token!, user.bearerToken!);
        myToast(
          msg: userModel.message,
          isNegative: false,
        );
        loadingLoginUser.value = false;
        Get.offAndToNamed(homescreen, arguments: user);
      });
    } else if (res.success == "true" && res.data?.rolename == "resident") {
      loadingLoginUser.value = false;
      myToast(
          msg: 'You are not Register to our System. Contact Admin',
          isNegative: true);
    } else {
      loadingLoginUser.value = false;
      error.value = res.toString();
      Get.snackbar("Error", error.value);
    }
  }

  void togglePasswordView() {
    isHidden = !isHidden;
    update();
  }

  Future fcmtokenrefresh(int id, String fcmtoken, String bearertoken) async {
    var res = await LoginService.fcmtokenrefresh(id: id, fcmtoken: fcmtoken);
    if (res['success'] == true) {
      myToast(msg: res['message'], isNegative: false);
    } else {
      myToast(msg: res['message'], isNegative: true);
    }
  }
}
