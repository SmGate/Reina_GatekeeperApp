// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gatekeeper/Module/NoticeBoard/Model/notice_board_model.dart';
import 'package:gatekeeper/Module/NoticeBoard/components/notice_board_card.dart';
import 'package:gatekeeper/Module/NoticeBoard/components/notice_board_dialogue.dart';
import 'package:gatekeeper/Widgets/new_widgets/loading.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:get/get.dart';
import '../../../Routes/set_routes.dart';
import '../../../Widgets/new_widgets/empty_list.dart';
import '../../../Widgets/new_widgets/my_back_button.dart';
import '../Controller/notice_board_controller.dart';

class NoticeBoardScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoticeBoardController>(
      init: NoticeBoardController(),
      builder: (controller) => WillPopScope(
        onWillPop: () async {
          Get.offNamed(homescreen, arguments: controller.userdata);
          return true;
        },
        child: SafeArea(
          child: Scaffold(
              backgroundColor: AppColors.background,
              body: Directionality(
                textDirection: TextDirection.ltr,
                child: Column(
                  children: [
                    MyBackButton(
                      text: 'notice_board'.tr,
                      onTap: () {
                        Get.offNamed(homescreen,
                            arguments: controller.userdata);
                      },
                    ),
                    Expanded(
                      child: FutureBuilder<NoticeBoardModel>(
                          future: controller.allNoticeBoard(
                            subadminid: controller.userdata.subadminid!,
                          ),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              if (controller.noticeBoardModel.data != null &&
                                  controller.noticeBoardModel.data?.length !=
                                      0) {
                                return ListView.builder(
                                    itemBuilder: (context, index) {
                                      var noticeBoardList = controller
                                          .noticeBoardModel.data![index];
                                      return GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                      backgroundColor:
                                                          AppColors.globalWhite,
                                                      surfaceTintColor:
                                                          AppColors.globalWhite,
                                                      content:
                                                          NoticeBoardDialogCard(
                                                        status: noticeBoardList
                                                            .status,
                                                        startDate:
                                                            noticeBoardList
                                                                .startdate
                                                                .toString(),
                                                        endDate: noticeBoardList
                                                            .enddate
                                                            .toString(),
                                                        title: noticeBoardList
                                                            .noticetitle,
                                                        description:
                                                            noticeBoardList
                                                                .noticedetail,
                                                        endTime: noticeBoardList
                                                            .endtime,
                                                        startTime:
                                                            noticeBoardList
                                                                .starttime,
                                                      )));
                                        },
                                        child: NoticeboardCard(
                                            title: noticeBoardList.noticetitle,
                                            description:
                                                noticeBoardList.noticedetail,
                                            startDate: noticeBoardList.startdate
                                                .toString()),
                                      );
                                    },
                                    itemCount: controller
                                        .noticeBoardModel.data?.length);
                              } else {
                                return EmptyList(
                                  name: 'No Notices',
                                );
                              }
                            } else if (snapshot.hasError) {
                              return Icon(Icons.error_outline);
                            } else {
                              return CircularIndicatorUnderWhiteBox();
                            }
                          }),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
