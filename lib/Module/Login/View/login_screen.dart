import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gatekeeper/Widgets/new_widgets/app_gradient.dart';
import 'package:gatekeeper/Widgets/new_widgets/my_password_textform_field.dart';
import 'package:gatekeeper/utils/Constants/images_strings.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:gatekeeper/utils/styles/text_style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/Constants/constants.dart';
import '../../../Widgets/new_widgets/my_button.dart';
import '../../../Widgets/new_widgets/my_textform_field.dart';
import '../Controller/login_controller.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<LoginController>(
            init: LoginController(),
            builder: (controller) {
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          38.h.ph,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 58.w),
                            child: Image.asset(
                              AppImages.logo,
                              width: 302.w,
                              height: 201.w,
                            ),
                          ),
                          33.91.h.ph,
                          Center(
                            child: Text(
                              "welcom_to".tr,
                              style: reusableTextStyle(
                                  textStyle: GoogleFonts.dmSans(),
                                  fontSize: 30.0,
                                  color: AppColors.textBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          19.h.ph,
                          Center(
                            child: Text(
                              "your_account".tr,
                              textAlign: TextAlign.center,
                              style: reusableTextStyle(
                                  textStyle: GoogleFonts.dmSans(),
                                  fontSize: 20.0,
                                  color: AppColors.dark,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          34.h.ph,
                          Padding(
                            padding: EdgeInsets.fromLTRB(158.w, 0, 0, 0),
                            child: Text(
                              "login".tr,
                              style: reusableTextStyle(
                                  textStyle: GoogleFonts.dmSans(),
                                  fontSize: 20.0,
                                  color: AppColors.appThem,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          38.h.ph,
                          MyTextFormField(
                            controller: controller.userCnicController,
                            textInputType: TextInputType.number,
                            validator: emptyStringValidator,
                            hintText: 'CNIC',
                            labelText: 'CNIC',
                            maxLenght: 15,
                            onChanged: (value) {
                              String formattedText = formatText(value);

                              controller.userCnicController.value =
                                  TextEditingValue(
                                text: formattedText,
                                selection: TextSelection.collapsed(
                                    offset: formattedText.length),
                              );
                            },
                          ),
                          MyPasswordTextFormField(
                              controller: controller.userPasswordController,
                              validator: emptyStringValidator,
                              labelText: 'Password',
                              hintText: 'Password',
                              togglePasswordView: controller.togglePasswordView,
                              obscureText: controller.isHidden),
                          45.h.ph,
                          Center(
                            child: Obx(() => MyButton(
                                  loading: controller.loadingLoginUser.value,
                                  gradient: AppGradients.buttonGradient,
                                  name: 'login'.tr,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      controller.loginUser(
                                          cnic: controller
                                              .userCnicController.text,
                                          password: controller
                                              .userPasswordController.text);
                                    }
                                  },
                                )),
                          ),
                          10.h.ph
                        ]),
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
