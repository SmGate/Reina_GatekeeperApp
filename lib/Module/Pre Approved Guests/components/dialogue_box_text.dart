import 'package:flutter/material.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:gatekeeper/utils/styles/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogBoxText extends StatelessWidget {
  final String? text;

  const DialogBoxText({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30),
      child: Text(
        text ?? "",
        style: reusableTextStyle(
            textStyle: GoogleFonts.dmSans(),
            fontSize: 12.0,
            color: AppColors.dark,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}
