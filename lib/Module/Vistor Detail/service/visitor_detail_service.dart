import 'package:gatekeeper/Module/Vistor%20Detail/Model/update_visitor_detail.model.dart';
import 'package:gatekeeper/Module/Vistor%20Detail/Model/visitor_detail_model.dart';
import 'package:gatekeeper/utils/Constants/api_routes.dart';
import 'package:gatekeeper/utils/Constants/base_client.dart';
import 'package:http/http.dart' as http;

class VisitorDetailService {
  static Future<dynamic> visitorDetail({int? societyId}) async {
    try {
      var url = Api.viewvistordetail + "/" + societyId.toString();
      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return visitorDetailModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> updateVisitorDetail({
    required int vid,
    required String checkoutdate,
    required String checkouttime,
  }) async {
    try {
      Map data = {
        "id": vid,
        "checkoutdate": checkoutdate,
        "checkouttime": checkouttime,
        "status": 1,
        "statusdescription": "check-out",
      };
      var url = Api.updateVistorStatus;
      var res = await BaseClientClass.post(url, data);

      if (res is http.Response) {
        return updateVisitorDetailModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}
