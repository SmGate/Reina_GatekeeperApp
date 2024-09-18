import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle reusableTextStyle({
  String? fontFamily, // Nullable String for Google font family
  TextStyle? textStyle, // TextStyle from GoogleFonts or default
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  double? letterSpacing,
  double? wordSpacing,
  double? height,
  TextDecoration? decoration,
}) {
  // If textStyle is provided, use it; otherwise, use GoogleFonts with fontFamily.
  if (textStyle != null) {
    return textStyle.copyWith(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      decoration: decoration,
    );
  }

  return GoogleFonts.getFont(
    fontFamily ?? 'Roboto', // Default font family
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    letterSpacing: letterSpacing,
    wordSpacing: wordSpacing,
    height: height,
    decoration: decoration,
  );
}
