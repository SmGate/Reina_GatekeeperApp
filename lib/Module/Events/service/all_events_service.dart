import 'package:gatekeeper/Module/Events/Model/all_events-model.dart';
import 'package:gatekeeper/utils/Constants/api_routes.dart';
import 'package:gatekeeper/utils/Constants/base_client.dart';
import 'package:http/http.dart' as http;

class AllEventsService {
  static Future<dynamic> getAllEvents({int? userId}) async {
    try {
      var url = Api.viewevent + "/" + userId.toString();
      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return allEventsModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}
