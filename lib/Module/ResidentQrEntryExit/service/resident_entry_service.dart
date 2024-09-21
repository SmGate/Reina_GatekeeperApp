import 'package:gatekeeper/Module/ResidentQrEntryExit/model/checkedin_residents_model.dart';
import 'package:gatekeeper/Module/ResidentQrEntryExit/model/update_resident_entry_model.dart';
import 'package:gatekeeper/utils/Constants/base_client.dart';
import 'package:http/http.dart' as http;

import '../../../utils/Constants/api_routes.dart';

class ResidentEntryService {
  static Future<dynamic> allCheckedInResident(
      {String? status,
      String? societyId,
      String? visitorType,
      int? pageKey,
      int? limit}) async {
    try {
      var url =
          "${Api.residentEntryExit}?status=$status&society_id=$societyId&visitortype=$visitorType&page=$pageKey&length=$limit";
      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return checkedInResidentModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> updateResidentEntryStatus(
      {int? societyId,
      int? residentId,
      int? gatekeeperId,
      int? subadminid}) async {
    try {
      Map data = {
        "resident_id": residentId,
        "gatekeeperid": gatekeeperId,
        "subadminid": subadminid
      };
      var url = "${Api.residentEntryExit}/$societyId";
      var res = await BaseClientClass.put(url, data);

      if (res is http.Response) {
        return updateResidentEntryModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}
