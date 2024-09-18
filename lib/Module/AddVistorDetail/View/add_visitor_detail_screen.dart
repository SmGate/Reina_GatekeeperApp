import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gatekeeper/Routes/set_routes.dart';
import 'package:gatekeeper/Widgets/new_widgets/app_gradient.dart';
import 'package:gatekeeper/Widgets/new_widgets/my_textform_field.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:gatekeeper/utils/styles/text_style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:searchfield/searchfield.dart';

import '../../../utils/Constants/constants.dart';
import '../../../Widgets/new_widgets/my_back_button.dart';
import '../../../Widgets/new_widgets/my_button.dart';
import '../Controller/add_vistor_detail_controller.dart';

class AddVisitorDetailScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: GetBuilder<AddVisitorDetailController>(
            init: AddVisitorDetailController(),
            builder: (controller) {
              return Form(
                key: controller.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MyBackButton(
                        text: 'Add Visitor Detail',
                        onTap: () {
                          Get.offNamed(homescreen,
                              arguments: controller.userdata);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15.w, 12.h, 17.w, 0),
                        child: Text(
                          "Visiting Type",
                          style: reusableTextStyle(
                              textStyle: GoogleFonts.dmSans(),
                              fontSize: 14.0,
                              color: AppColors.textBlack,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15.w, 12.h, 17.w, 0),
                        child: DropdownButton(
                          style: GoogleFonts.ubuntu(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: Colors.black),
                          value: controller.visitingTypeDropDownValue,
                          isExpanded: true,
                          icon: Icon(
                            Icons.arrow_drop_down_sharp,
                            color: AppColors.appThem,
                          ),
                          items: controller.visitingTypesList.map((items) {
                            return DropdownMenuItem(
                              value: items..toString(),
                              child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    children: [Text(items.toString())],
                                  )),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            controller.setVisitingType(newValue);
                          },
                        ),
                      ),
                      (controller.visitingTypeDropDownValue == 'Society Visit')
                          ? Column(
                              children: [
                                MyTextFormField(
                                  controller: controller.nameController,
                                  validator: emptyStringValidator,
                                  labelText: 'Name',
                                  hintText: 'Name',
                                ),
                                MyTextFormField(
                                  controller: controller.cnicController,
                                  // validator: emptyStringValidator,
                                  labelText: 'Cnic',
                                  hintText: 'Cnic',
                                  textInputType: TextInputType.number,
                                  maxLenght: 15,
                                  validator: emptyStringValidator,
                                  onChanged: (value) {
                                    String formattedText = formatText(value);
                                    controller.cnicController.value =
                                        TextEditingValue(
                                      text: formattedText,
                                      selection: TextSelection.collapsed(
                                          offset: formattedText.length),
                                    );
                                  },
                                ),
                                MyTextFormField(
                                  controller: controller.mobileNoController,
                                  validator: emptyStringValidator,
                                  labelText: 'Mobile Number',
                                  hintText: 'Mobile Number',
                                  textInputType: TextInputType.number,
                                ),
                                MyTextFormField(
                                  controller: controller.vehicleNoController,
                                  validator: emptyStringValidator,
                                  labelText: 'Vehicle Number',
                                  hintText: 'Vehicle Number',
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(15.w, 12.h, 17.w, 0),
                                  child: Text(
                                    "Visitor Type",
                                    style: reusableTextStyle(
                                        textStyle: GoogleFonts.dmSans(),
                                        fontSize: 14.0,
                                        color: AppColors.textBlack,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(15.w, 12.h, 17.w, 0),
                                  child: DropdownButton(
                                    style: GoogleFonts.ubuntu(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                        color: Colors.black),
                                    value: controller.visitorTypeDropDownValue,
                                    isExpanded: true,
                                    icon: Icon(
                                      Icons.arrow_drop_down_sharp,
                                      color: AppColors.appThem,
                                    ),
                                    items: controller.visitorTypesList
                                        .map((items) {
                                      return DropdownMenuItem(
                                        value: items..toString(),
                                        child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Row(
                                              children: [
                                                Text(items.toString())
                                              ],
                                            )),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      controller.setVisitorType(newValue);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(15.w, 12.h, 17.w, 0),
                                  child: Text(
                                    "Search Resident",
                                    style: GoogleFonts.ubuntu(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: HexColor('#4D4D4D')),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(15.w, 12.h, 17.w, 0),
                                  child: SearchField(
                                    itemHeight: 70,
                                    suggestionStyle:
                                        GoogleFonts.ubuntu(fontSize: 16.sp),
                                    autoCorrect: true,
                                    validator: (x) {
                                      if (controller.li.contains(x) ||
                                          x!.isEmpty) {
                                        return 'Please Enter a valid Address';
                                      }
                                      return null;
                                    },
                                    onSearchTextChanged: (query) {
                                      final filter = controller.li
                                          .where((element) => element
                                              .houseaddress
                                              .toLowerCase()
                                              .contains(query.toLowerCase()))
                                          .toList();
                                      return filter
                                          .map((e) =>
                                              SearchFieldListItem<String>(
                                                  e.houseaddress))
                                          .toList();
                                    },
                                    key: const Key('search field'),
                                    hint: 'Search by House Address',
                                    suggestions: controller.li
                                        .map((e) => SearchFieldListItem<String>(
                                            e.houseaddress))
                                        .toList(),
                                    focusNode: controller.focus,
                                    searchStyle: GoogleFonts.ubuntu(),
                                    suggestionState: Suggestion.expand,
                                    onSuggestionTap:
                                        (SearchFieldListItem<String> x) {
                                      controller.focus.unfocus();
                                    },
                                    controller:
                                        controller.searchAddressController,
                                  ),
                                ),
                                MyTextFormField(
                                  controller: controller.nameController,
                                  validator: emptyStringValidator,
                                  labelText: 'Name',
                                  hintText: 'Name',
                                ),
                                MyTextFormField(
                                  controller: controller.cnicController,
                                  // validator: emptyStringValidator,
                                  labelText: 'Cnic',
                                  hintText: 'Cnic',
                                  textInputType: TextInputType.number,
                                ),
                                MyTextFormField(
                                  controller: controller.mobileNoController,
                                  validator: emptyStringValidator,
                                  labelText: 'Mobile Number',
                                  hintText: 'Mobile Number',
                                  textInputType: TextInputType.number,
                                ),
                                MyTextFormField(
                                  controller: controller.vehicleNoController,
                                  validator: emptyStringValidator,
                                  labelText: 'Vehicle Number',
                                  hintText: 'Vehicle Number',
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Obx(() => MyButton(
                            gradient: AppGradients.buttonGradient,
                            loading: controller.isLoading.value,
                            name: 'Check-In',
                            onPressed: () {
                              if (controller.formKey.currentState!.validate()) {
                                if (controller.visitingTypeDropDownValue ==
                                    'Society Visit') {
                                  controller.currentDate = controller
                                          .currentDateTime.year
                                          .toString() +
                                      "-" +
                                      controller.currentDateTime.month
                                          .toString() +
                                      "-" +
                                      controller.currentDateTime.day.toString();

                                  controller.currentTime = controller
                                          .currentDateTime.hour
                                          .toString() +
                                      ":" +
                                      controller.currentDateTime.minute
                                          .toString() +
                                      ":" +
                                      controller.currentDateTime.second
                                          .toString();

                                  if (!controller.isLoading.value) {
                                    controller.addVisitorDetail(
                                        societyid:
                                            controller.userdata.societyid!,
                                        subadminid:
                                            controller.userdata.subadminid!,
                                        cnic: controller.cnicController.text,
                                        name: controller.nameController.text,
                                        mobileno:
                                            controller.mobileNoController.text,
                                        houseaddress: 'Society Visitor',
                                        arrivaldate: controller.currentDate!,
                                        arrivaltime: controller.currentTime!,
                                        vechileno:
                                            controller.vehicleNoController.text,
                                        visitortype: 'Society Visitor',
                                        gatekeeperid:
                                            controller.userdata.userid!);
                                  }
                                } else {
                                  controller.currentDate = controller
                                          .currentDateTime.year
                                          .toString() +
                                      "-" +
                                      controller.currentDateTime.month
                                          .toString() +
                                      "-" +
                                      controller.currentDateTime.day.toString();

                                  controller.currentTime = controller
                                          .currentDateTime.hour
                                          .toString() +
                                      ":" +
                                      controller.currentDateTime.minute
                                          .toString() +
                                      ":" +
                                      controller.currentDateTime.second
                                          .toString();

                                  if (!controller.isLoading.value) {
                                    controller.addVisitorDetail(
                                        societyid:
                                            controller.userdata.societyid!,
                                        subadminid:
                                            controller.userdata.subadminid!,
                                        cnic: controller.cnicController.text,
                                        name: controller.nameController.text,
                                        mobileno:
                                            controller.mobileNoController.text,
                                        houseaddress: controller
                                            .searchAddressController.text,
                                        arrivaldate: controller.currentDate!,
                                        arrivaltime: controller.currentTime!,
                                        vechileno:
                                            controller.vehicleNoController.text,
                                        visitortype: controller
                                            .visitorTypeDropDownValue!,
                                        gatekeeperid:
                                            controller.userdata.userid!);
                                  }
                                }
                              }
                            })),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  /////  formate cnic text

  String formatText(String text) {
    text = text.replaceAll(RegExp(r'\D'), '');

    if (text.length > 15) {
      text = text.substring(0, 15);
    }

    String formattedText = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 5 || i == 12) {
        formattedText += '-';
      }
      formattedText += text[i];
    }

    return formattedText;
  }
}
