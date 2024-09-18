import 'dart:convert';

import 'package:gatekeeper/Module/Login/Model/login_user_model.dart';
import 'package:gatekeeper/utils/Constants/api_routes.dart';
import 'package:gatekeeper/utils/Constants/base_client.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static Future<LoginUserModel> loginUser(
      {String? cnic, String? password}) async {
    try {
      Map data = {
        'cnic': cnic,
        'password': password,
      };
      var url = Api.login;
      var res = await BaseClientClass.post(url, data);

      if (res is http.Response) {
        return loginUserModelFromJson(res.body);
      } else {
        return LoginUserModel(message: res.toString());
      }
    } catch (e) {
      return LoginUserModel(message: e.toString());
    }
  }

  static Future<dynamic> fcmtokenrefresh({
    int? id,
    String? fcmtoken,
  }) async {
    try {
      Map data = {
        'id': id,
        'fcmtoken': fcmtoken,
      };
      var url = Api.fcmtokenrefresh;
      var res = await BaseClientClass.post(url, data);

      if (res is http.Response) {
        return json.decode(res.body);
      } else {
        return LoginUserModel(message: res.toString());
      }
    } catch (e) {
      return LoginUserModel(message: e.toString());
    }
  }
}
