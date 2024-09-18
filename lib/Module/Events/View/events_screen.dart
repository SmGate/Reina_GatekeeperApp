// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gatekeeper/Module/Events/Model/all_events-model.dart';
import 'package:gatekeeper/Module/Events/components/event_card.dart';
import 'package:gatekeeper/Module/Events/components/events_dialogue.dart';
import 'package:gatekeeper/Widgets/new_widgets/empty_list.dart';
import 'package:gatekeeper/Widgets/new_widgets/loading.dart';
import 'package:gatekeeper/utils/Constants/images_strings.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/Constants/constants.dart';
import '../../../Helpers/Date Helper/date_helper.dart';
import '../../../Routes/set_routes.dart';
import '../../../Widgets/new_widgets/my_back_button.dart';
import '../Controller/event_screen_controller.dart';

class EventsScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventScreenController>(
        init: EventScreenController(),
        builder: (controller) {
          return WillPopScope(
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
                        text: 'society_events'.tr,
                        onTap: () {
                          Get.offNamed(homescreen,
                              arguments: controller.userdata);
                        },
                      ),
                      Expanded(
                        child: FutureBuilder<AllEventsModel>(
                            future: controller.allEvents(
                              userid: controller.userdata.subadminid!,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data != null &&
                                    snapshot.data!.data!.length != 0) {
                                  return ListView.builder(
                                      itemBuilder: (context, index) {
                                        var allEvents = controller
                                            .allEventsModel.data?[index];
                                        // controller.snapShot =
                                        //     snapshot.data!.data![index];

                                        return GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                            backgroundColor:
                                                                AppColors
                                                                    .globalWhite,
                                                            surfaceTintColor:
                                                                AppColors
                                                                    .globalWhite,
                                                            content: EventDialog(
                                                                startTime:
                                                                    allEvents?.starttime ??
                                                                        "",
                                                                endTime: allEvents
                                                                        ?.endtime ??
                                                                    "",
                                                                title: allEvents
                                                                        ?.title ??
                                                                    "",
                                                                startDate: allEvents
                                                                    ?.startdate
                                                                    .toString(),
                                                                endDate: allEvents
                                                                    ?.enddate
                                                                    .toString(),
                                                                description:
                                                                    allEvents
                                                                        ?.description),
                                                          ));
                                            },
                                            child: EventCard(
                                              title: allEvents?.title,
                                              description:
                                                  allEvents?.description,
                                              startDate: allEvents?.startdate
                                                  .toString(),
                                              index: index,
                                              img: allEvents
                                                      ?.images?.first.image ??
                                                  "",
                                            ));
                                      },
                                      itemCount: controller
                                          .allEventsModel.data?.length);
                                } else {
                                  return EmptyList(name: 'No Events');
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
                ),
              ),
            ),
          );
        });
  }
}

class EventDateCard extends StatelessWidget {
  final String? dateString;

  const EventDateCard({super.key, required this.dateString});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 93.w,
      height: 18.w,
      decoration: BoxDecoration(
          color: HexColor('#E1E1E1'), borderRadius: BorderRadius.circular(4.r)),
      child: Row(
        children: [
          6.w.pw,
          SvgPicture.asset(
            AppImages.date,
            width: 12.w,
            height: 12.w,
          ),
          8.w.pw,
          Text(
              DateHelper.convertDateFormatToDayMonthYearDateFormat(dateString!),
              style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.w300,
                  fontSize: 10.sp,
                  color: HexColor('#4D4D4D')))
        ],
      ),
    );
  }
}
