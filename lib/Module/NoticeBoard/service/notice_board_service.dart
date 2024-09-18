import 'package:gatekeeper/Module/NoticeBoard/Model/notice_board_model.dart';
import 'package:gatekeeper/utils/Constants/api_routes.dart';
import 'package:gatekeeper/utils/Constants/base_client.dart';
import 'package:http/http.dart' as http;

class NoticeBoardService {
  static Future<dynamic> allNoticeBoard({int? subadminid}) async {
    try {
      var url = Api.viewallnoticesapi + "/" + subadminid.toString();
      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return noticeBoardModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}
