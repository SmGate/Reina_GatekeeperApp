// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gatekeeper/Module/Vistor%20Detail/componet/visitor_dialogue.dart';
import 'package:gatekeeper/Module/Vistor%20Detail/componet/vistorcard.dart';
import 'package:gatekeeper/Widgets/new_widgets/empty_list.dart';
import 'package:gatekeeper/Widgets/new_widgets/app_gradient.dart';
import 'package:gatekeeper/Widgets/new_widgets/loading.dart';
import 'package:gatekeeper/Widgets/new_widgets/my_textform_field.dart';

import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:gatekeeper/Module/Vistor%20Detail/Model/visitor_detail_model.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../Routes/set_routes.dart';
import '../../../Widgets/new_widgets/my_back_button.dart';
import '../Controller/visitor_detail_controller.dart';

class VisitorDetailScreen extends GetView<VisitorDetailController> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<VisitorDetailController>();
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(homescreen, arguments: controller.userdata);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.background,
          floatingActionButton: Container(
            decoration: BoxDecoration(
              gradient: AppGradients.floatingbuttonGradient,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              iconSize: 50,
              icon: Icon(Icons.add, color: AppColors.globalWhite),
              onPressed: () {
                Get.offNamed(addVistorDetailScreen,
                    arguments: controller.userdata);
              },
            ),
          ),
          body: Directionality(
            textDirection: TextDirection.ltr,
            child: Column(
              children: [
                MyBackButton(
                  text: 'visitor'.tr,
                  onTap: () {
                    Get.offNamed(homescreen, arguments: controller.userdata);
                  },
                ),
                MyTextFormField(
                  hintText: "Search Visitor",
                  labelText: "Search Visitor",
                  onChanged: (v) {
                    controller.searchValue.value = v.toLowerCase();
                  },
                ),
                Expanded(
                  child: PagedListView(
                    shrinkWrap: true,
                    primary: false,
                    pagingController: controller.pagingController,
                    addAutomaticKeepAlives: false,
                    builderDelegate: PagedChildBuilderDelegate(
                      firstPageProgressIndicatorBuilder: (context) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 250),
                            child: CircularIndicatorUnderWhiteBox(),
                          ),
                        );
                      },
                      newPageProgressIndicatorBuilder: (context) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                                color: AppColors.appThem),
                          ),
                        );
                      },
                      noItemsFoundIndicatorBuilder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 200),
                          child: EmptyList(name: 'No Entries'),
                        );
                      },
                      itemBuilder: (context, item, index) {
                        final Datum visitors = item as Datum;
                        if (visitors.status == 0) {
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    VisitorDialogue(visitors, context),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 13, 22, 0),
                              child: Obx(() {
                                if (controller.searchValue.value.isEmpty ||
                                    (visitors.name?.toLowerCase().contains(
                                            controller.searchValue.value) ??
                                        false)) {
                                  return VisitorCard(
                                      controller: controller,
                                      visitors: visitors);
                                } else {
                                  return SizedBox(); // Empty widget when no match
                                }
                              }),
                            ),
                          );
                        } else {
                          return SizedBox(); // Empty widget for invalid status
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget MyStatusWidget(
    {required status,
    required color,
    Color? textColor,
    double? width,
    double? height,
    void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width ?? 64,
      height: height ?? 18,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      child: Center(
        child: Text(
          status,
          style: TextStyle(
            fontSize: 10,
            color: textColor ?? HexColor('#FFFFFF'),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ),
  );
}
