// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:gatekeeper/Module/ResidentQrEntryExit/components/dialogue.dart';
import 'package:gatekeeper/Module/ResidentQrEntryExit/model/checkedin_residents_model.dart';
import 'package:gatekeeper/Routes/set_routes.dart';
import 'package:gatekeeper/Widgets/new_widgets/custom_container.dart';
import 'package:gatekeeper/Widgets/new_widgets/loading.dart';
import 'package:gatekeeper/Widgets/new_widgets/my_textform_field.dart';
import 'package:gatekeeper/utils/Constants/images_strings.dart';

import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:gatekeeper/utils/styles/text_style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../Widgets/new_widgets/empty_list.dart';
import '../../../Widgets/new_widgets/my_back_button.dart';
import '../controller/resident_qr_entry_exit_controller.dart';
import 'resident-qr_entry_exit.dart';

class AllResidentRecord extends StatelessWidget {
  AllResidentRecord({super.key});

  var controller = Get.put(ResidentQrEntryController());

  @override
  Widget build(BuildContext context) {
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
                    text: 'resident_history'.tr,
                    onTap: () {
                      Get.offNamed(homescreen, arguments: controller.userdata);
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MyTextFormField(
                          hintText: "Search Name ",
                          labelText: "Search Name",
                          onChanged: (v) {
                            controller.searchValue.value = v;
                          },
                        ),
                      ),
                    ],
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
                            child:
                                Center(child: CircularIndicatorUnderWhiteBox()),
                          ));
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
                            child: EmptyList(
                              name: 'No Entrise',
                            ),
                          );
                        },
                        itemBuilder: (context, item, index) {
                          final Datum residents = item as Datum;
                          return Obx(() {
                            if ((residents.name!.toLowerCase().contains(
                                        controller.searchValue.value) &&
                                    controller.searchValue.value.isNotEmpty) ||
                                controller.searchValue.value.isEmpty) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    top: index == 0 ? 20 : 15,
                                    left: 20,
                                    right: 20),
                                child: ResidentCard(residents: residents),
                              );
                            } else {
                              return Container();
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Get.to(() => ResidentQrEntryExit());
                      },
                      icon: Icon(
                        Icons.qr_code_2,
                        size: 60,
                      )),
                ],
              )),
        ),
      ),
    );
  }
}

class ResidentCard extends StatelessWidget {
  const ResidentCard({
    super.key,
    required this.residents,
  });

  final Datum residents;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    backgroundColor: AppColors.globalWhite,
                    surfaceTintColor: AppColors.globalWhite,
                    content: ResidentsDialogCard(
                      residents: residents,
                    ),
                  ));
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    AppImages.demoUser,
                    height: 40,
                    //color: AppColors.globalWhite,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        residents.name ?? "",
                        style: reusableTextStyle(
                            textStyle: GoogleFonts.dmSans(),
                            fontSize: 14.0,
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            "Mobile  ",
                            style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 14.0,
                                color: AppColors.textBlack,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            residents.mobileno ?? "",
                            style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 14.0,
                                color: AppColors.dark,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Status     ",
                            style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 14.0,
                                color: AppColors.textBlack,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            residents.statusdescription ?? "",
                            style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 14.0,
                                color: AppColors.dark,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
