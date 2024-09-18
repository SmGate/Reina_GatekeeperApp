import 'package:gatekeeper/Module/Residental%20Emergency/Model/residential_emergency_model.dart';
import 'package:gatekeeper/utils/Constants/api_routes.dart';
import 'package:gatekeeper/utils/Constants/base_client.dart';
import 'package:http/http.dart' as http;

class ResidentialEmergencyService {
  static Future<dynamic> residentialEmergencies({
    int? subadminid,
  }) async {
    try {
      var url = Api.viewEmergency + "/" + subadminid.toString();
      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return residentialEmergencyModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}
