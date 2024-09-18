import 'package:gatekeeper/Module/AddVistorDetail/Model/add_visitor_detail_model.dart';
import 'package:gatekeeper/utils/Constants/api_routes.dart';
import 'package:gatekeeper/utils/Constants/base_client.dart';
import 'package:http/http.dart' as http;

class AddVisitorDetailService {
  static Future<dynamic> updateVisitorDetail({
    required int gatekeeperid,
    required int societyid,
    required int subadminid,
    String? houseaddress,
    required String visitortype,
    required String name,
    required String cnic,
    required String mobileno,
    required String vechileno,
    required String arrivaldate,
    required String arrivaltime,
  }) async {
    try {
      Map data = {
        "gatekeeperid": gatekeeperid,
        "societyid": societyid,
        "subadminid": subadminid,
        "houseaddress": houseaddress,
        "visitortype": visitortype,
        "name": name,
        "cnic": cnic,
        "mobileno": mobileno,
        "vechileno": vechileno,
        "arrivaldate": arrivaldate,
        "arrivaltime": arrivaltime,
        "checkoutdate": arrivaldate,
        "checkouttime": arrivaltime,
        "status": 0,
        "statusdescription": "checkin",
      };
      var url = Api.addvistordetail;
      var res = await BaseClientClass.post(url, data);

      if (res is http.Response) {
        return addVisitorDetailModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}
