import 'package:gatekeeper/Module/NoticeBoard/Model/notice_board_model.dart';
import 'package:gatekeeper/Module/NoticeBoard/service/notice_board_service.dart';
import 'package:get/get.dart';
import '../../Login/Model/User.dart';

class NoticeBoardController extends GetxController {
  var data = Get.arguments;

  late final User userdata;
  var snapShot;

  var noticeBoardModel = NoticeBoardModel();
  var error = "";
  @override
  void onInit() {
    super.onInit();
    userdata = data;
  }

  Future<NoticeBoardModel> allNoticeBoard({
    required int subadminid,
  }) async {
    error = "";
    var res = await NoticeBoardService.allNoticeBoard(subadminid: subadminid);
    if (res is NoticeBoardModel) {
      noticeBoardModel = res;
      return noticeBoardModel;
    } else {
      error = res.toString();
      Get.snackbar("Error", error);
    }

    return noticeBoardModel;
  }
}
