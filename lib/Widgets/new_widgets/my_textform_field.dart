// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class MyTextFormField extends GetView {
  final TextEditingController? controller;
  final String? hintText;
  final FontWeight? fontWeight;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool? fill;
  final bool? readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? contentPadding;
  final double? fontSize;
  final String? labelText;
  final int? maxLines;
  final Color? labelTextColor;
  final Color? hintTextColor;
  final Color? fillColor;
  final TextInputType? textInputType;
  void Function(String)? onChanged;
  int? maxLenght;

  final String? Function(String?)? validator;
  final void Function()? onTap;
  MyTextFormField(
      {super.key,
      this.maxLines,
      this.textAlign,
      this.padding,
      this.readOnly,
      this.textInputType,
      this.contentPadding,
      this.prefixIcon,
      this.suffixIcon,
      this.fontWeight,
      this.fill,
      this.fontSize,
      this.onTap,
      this.width,
      this.height,
      this.controller,
      this.fillColor,
      this.validator,
      required this.hintText,
      this.labelTextColor,
      required this.labelText,
      this.hintTextColor,
      this.onChanged,
      this.maxLenght});

  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.fromLTRB(15.w, 12.h, 17.w, 0),
      child: SizedBox(
        width: width ?? 343.w,
        // height: height ?? 43.w,
        child: TextFormField(
          onChanged: onChanged,
          maxLength: maxLenght ?? 1000,
          style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w400,
              fontSize: 15.sp,
              letterSpacing: 0.05),
          //  inputFormatters: [inputFormatter!],
          keyboardType: textInputType,
          // obscureText: widget.obscureText,
          textAlign: textAlign ?? TextAlign.start,
          onTap: onTap,
          validator: validator,
          maxLines: maxLines ?? 1,
          controller: controller,
          cursorColor: AppColors.appThem,
          readOnly: readOnly ?? false,
          decoration: InputDecoration(
            // enabledBorder: InputBorder.none,
            errorStyle: GoogleFonts.ubuntu(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              fontSize: 10.sp,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0.r),
              borderSide: BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0.r),
              borderSide: BorderSide(color: AppColors.appThem, width: 1.5),
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding:
                contentPadding ?? EdgeInsets.fromLTRB(25.w, 13.h, 0.w, 13.h),

            filled: fill ?? true,

            labelStyle: GoogleFonts.ubuntu(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 15.sp,
                color: labelTextColor ?? HexColor('#555555')),
            hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              color: hintTextColor ?? HexColor("#555555"),
            ),
            hintText: hintText,
            labelText: labelText,
            fillColor: fillColor ?? HexColor('#EEEEEE'),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0.r),
              borderSide: BorderSide(color: AppColors.appThem, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0.r),
              borderSide: BorderSide(color: AppColors.appThem, width: 1.5),
            ),
          ),
        ),
      ),
    );
  }
}
