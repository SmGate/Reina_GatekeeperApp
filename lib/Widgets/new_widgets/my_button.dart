import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:gatekeeper/utils/styles/text_style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends GetView {
  final OutlinedBorder? outlinedBorder;
  final double? height;
  final double? width;
  final bool loading;
  final double? elevation;
  final double? fontSize;
  final double? letterSpacing;
  final FontWeight? fontWeight;
  final double? border;
  final String name;
  final Color? color; // This color is ignored if gradient is provided.
  final FontStyle? fontStyle;
  final Color? textColor;
  final int? maxLines;
  final void Function()? onPressed;
  final Gradient? gradient; // Add a gradient parameter

  const MyButton({
    super.key,
    this.outlinedBorder,
    this.loading = false,
    this.fontStyle,
    this.elevation,
    this.fontWeight,
    this.letterSpacing,
    this.fontSize,
    this.textColor,
    this.height,
    this.width,
    this.border,
    required this.name,
    this.color,
    this.maxLines,
    this.onPressed,
    this.gradient, // Initialize gradient parameter
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 180.w,
      height: height ?? 43.w,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          gradient: gradient,
          borderRadius: BorderRadius.circular(border ?? 300),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: elevation ?? 5,
            shape: outlinedBorder ??
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(border ?? 300),
                ), // Make button background transparent
          ),
          onPressed: onPressed,
          child: loading
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  name,
                  maxLines: maxLines ?? 1,
                  style: reusableTextStyle(
                      textStyle: GoogleFonts.dmSans(),
                      fontSize: fontSize ?? 18.0,
                      color: AppColors.textBlack,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }
}
