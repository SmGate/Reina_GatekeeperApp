import 'package:gatekeeper/Module/Pre%20Approved%20Guests/model/pre_approved_guest_model.dart';
import 'package:gatekeeper/Module/Pre%20Approved%20Guests/model/update_pre_approved_entry_status.dart';
import 'package:gatekeeper/utils/Constants/api_routes.dart';
import 'package:gatekeeper/utils/Constants/base_client.dart';
import 'package:http/http.dart' as http;

class PreApprovedGuestService {
  static Future<dynamic> preApprovedGuest({
    int? userid,
  }) async {
    try {
      var url = Api.preapproveentries + "/" + userid.toString();
      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return preApprovedGuestModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> updatePreApprovedEntryStatus({
    required int id,
    required int status,
    required String statusdescription,
    required String cnic,
    required String vechileno,
  }) async {
    try {
      Map data = {
        "id": id,
        "status": status,
        "statusdescription": statusdescription,
        "cnic": cnic,
        "vechileno": vechileno,
      };
      var url = Api.updatepreapproveentrystatus;
      var res = await BaseClientClass.post(url, data);

      if (res is http.Response) {
        return updatePreApprovedEntryStatusModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}
