// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gatekeeper/Module/ResidentQrEntryExit/components/dialogue.dart';
import 'package:gatekeeper/Module/ResidentQrEntryExit/model/checkedin_residents_model.dart';
import 'package:gatekeeper/Routes/set_routes.dart';
import 'package:gatekeeper/Widgets/new_widgets/custom_container.dart';
import 'package:gatekeeper/Widgets/new_widgets/loading.dart';
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
  const AllResidentRecord({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ResidentQrEntryController>();
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
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.only(left: 20, right: 20, top: 20),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     children: [
                  //       Expanded(
                  //         child: Container(
                  //           padding: EdgeInsets.symmetric(
                  //               horizontal: 12, vertical: 5),
                  //           decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             borderRadius:
                  //                 BorderRadius.circular(12), // Rounded corners
                  //           ),
                  //           child: Obx(() {
                  //             return DropdownButtonHideUnderline(
                  //               child: DropdownButton<String>(
                  //                 hint: Text(
                  //                   "Select Option",
                  //                   style: TextStyle(fontSize: 12),
                  //                 ),
                  //                 value: controller.selectedValue?.value
                  //                             .isNotEmpty ==
                  //                         true
                  //                     ? controller.selectedValue?.value
                  //                     : null,
                  //                 items: controller.items.map((String item) {
                  //                   return DropdownMenuItem<String>(
                  //                     value: item,
                  //                     child: Text(
                  //                       item,
                  //                       style: TextStyle(fontSize: 12),
                  //                     ),
                  //                   );
                  //                 }).toList(),
                  //                 onChanged: (String? newValue) {
                  //                   // String formattedValue = newValue!
                  //                   //     .toLowerCase()
                  //                   //     .replaceAll('-', '');
                  //                   controller.setSelected(newValue!);
                  //                 },
                  //                 isExpanded: true,
                  //                 dropdownColor: Colors.white,
                  //               ),
                  //             );
                  //           }),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: 30,
                  //       ),
                  //       Expanded(
                  //         child: Container(
                  //           padding: EdgeInsets.symmetric(
                  //               horizontal: 12, vertical: 5),
                  //           decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             borderRadius:
                  //                 BorderRadius.circular(12), // Rounded corners
                  //           ),
                  //           child: Obx(() {
                  //             return DropdownButtonHideUnderline(
                  //               child: DropdownButton<String>(
                  //                 hint: Text(
                  //                   "Select Option",
                  //                   style: TextStyle(fontSize: 12),
                  //                 ),
                  //                 value: controller.selectedVisitorType?.value
                  //                                 .isNotEmpty ==
                  //                             true &&
                  //                         controller.vistorType.contains(
                  //                             controller
                  //                                 .selectedVisitorType?.value)
                  //                     ? controller.selectedVisitorType?.value
                  //                     : null,
                  //                 items:
                  //                     controller.vistorType.map((String item) {
                  //                   return DropdownMenuItem<String>(
                  //                     value: item,
                  //                     child: Text(
                  //                       item,
                  //                       style: TextStyle(fontSize: 12),
                  //                     ),
                  //                   );
                  //                 }).toList(),
                  //                 onChanged: (String? newValue) {
                  //            controller.setSelectedVisitorType(newValue!); // Update the selected value
                  //                 },
                  //                 isExpanded: true,
                  //                 dropdownColor: Colors.white,
                  //               ),
                  //             );
                  //           }),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
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
                            child: CircularProgressIndicator(
                                color: AppColors.appThem),
                          );
                        },
                        noItemsFoundIndicatorBuilder: (context) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 300),
                            child: EmptyList(
                              name: 'No Complains',
                            ),
                          );
                        },
                        itemBuilder: (context, item, index) {
                          final Datum residents = item as Datum;

                          return Padding(
                            padding: EdgeInsets.only(
                                top: index == 0 ? 20 : 15, left: 20, right: 20),
                            child: CustomCard(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            backgroundColor:
                                                AppColors.globalWhite,
                                            surfaceTintColor:
                                                AppColors.globalWhite,
                                            content: ResidentsDialogCard(
                                              residents: residents,
                                            ),
                                          ));
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                residents.name ?? "",
                                                style: reusableTextStyle(
                                                    textStyle:
                                                        GoogleFonts.dmSans(),
                                                    fontSize: 14.0,
                                                    color: AppColors.textBlack,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Mobile  ",
                                                    style: reusableTextStyle(
                                                        textStyle: GoogleFonts
                                                            .dmSans(),
                                                        fontSize: 14.0,
                                                        color:
                                                            AppColors.textBlack,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  Text(
                                                    residents.mobileno ?? "",
                                                    style: reusableTextStyle(
                                                        textStyle: GoogleFonts
                                                            .dmSans(),
                                                        fontSize: 14.0,
                                                        color: AppColors.dark,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "CNIC     ",
                                                    style: reusableTextStyle(
                                                        textStyle: GoogleFonts
                                                            .dmSans(),
                                                        fontSize: 14.0,
                                                        color:
                                                            AppColors.textBlack,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  Text(
                                                    residents.cnic ?? "",
                                                    style: reusableTextStyle(
                                                        textStyle: GoogleFonts
                                                            .dmSans(),
                                                        fontSize: 14.0,
                                                        color: AppColors.dark,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Status     ",
                                                    style: reusableTextStyle(
                                                        textStyle: GoogleFonts
                                                            .dmSans(),
                                                        fontSize: 14.0,
                                                        color:
                                                            AppColors.textBlack,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  Text(
                                                    residents
                                                            .statusdescription ??
                                                        "",
                                                    style: reusableTextStyle(
                                                        textStyle: GoogleFonts
                                                            .dmSans(),
                                                        fontSize: 14.0,
                                                        color: AppColors.dark,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                          );
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
