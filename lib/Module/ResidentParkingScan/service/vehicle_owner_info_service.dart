import 'package:gatekeeper/Module/ResidentParkingScan/model/send_notification_to_resident_model.dart';
import 'package:gatekeeper/Module/ResidentParkingScan/model/vehicle_owner_info_model.dart';
import 'package:gatekeeper/utils/Constants/api_routes.dart';
import 'package:gatekeeper/utils/Constants/base_client.dart';
import 'package:http/http.dart' as http;

class VehicleOwnerService {
  static Future<dynamic> getVehicleOwnerData({
    String? vehicleNo,
  }) async {
    try {
      var url = Api.vehicleOwnerDetail + "/" + vehicleNo.toString();
      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return vehicleOwnerModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> sendNotificationToResident({
    String? residentId,
  }) async {
    try {
      var url = Api.sendNotificationToResident + "/" + residentId.toString();
      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return sendNotificationToResidentModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}
