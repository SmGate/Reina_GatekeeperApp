import 'package:gatekeeper/Module/Pre%20Approve%20Entry%20Residents/Model/pre_approved_entry_model.dart';
import 'package:gatekeeper/utils/Constants/api_routes.dart';
import 'package:gatekeeper/utils/Constants/base_client.dart';
import 'package:http/http.dart' as http;

class PreApprovedEntryService {
  static Future<dynamic> preApprovedEntry({
    int? userid,
  }) async {
    try {
      var url = Api.preapproveentryresidents + "/" + userid.toString();
      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return preApprovedEntryModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}
