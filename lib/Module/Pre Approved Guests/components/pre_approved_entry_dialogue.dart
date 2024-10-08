import 'package:flutter/material.dart';
import 'package:gatekeeper/Module/Pre%20Approved%20Guests/components/dialogue_box_text.dart';
import 'package:gatekeeper/Widgets/new_widgets/dialog_box_elipse_heading.dart';
import 'package:gatekeeper/Widgets/new_widgets/app_gradient.dart';
import 'package:gatekeeper/Widgets/new_widgets/my_button.dart';
import 'package:gatekeeper/utils/Constants/constants.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:gatekeeper/utils/styles/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

class PreApproveEntryDialog extends StatelessWidget {
  final String? name;
  final String? description;
  final String? visitortype;
  final String? vechileno;
  final String? mobileno;
  final String? arrivaldate;
  final String? arrivaltime;
  final String? cnic;

  const PreApproveEntryDialog(
      {super.key,
      required this.name,
      required this.description,
      required this.visitortype,
      required this.vechileno,
      required this.mobileno,
      required this.arrivaldate,
      required this.arrivaltime,
      required this.cnic});

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                name ?? "",
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 16.0,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                description ?? "",
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 14.0,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.bold),
              ),
            ),
            23.33.ph,
            DialogBoxElipseHeading(text: 'Visitor Type'),
            DialogBoxText(
              text: visitortype ?? "",
            ),
            23.33.ph,
            DialogBoxElipseHeading(text: 'Vechile No'),
            DialogBoxText(
              text: vechileno ?? "",
            ),
            23.33.ph,
            DialogBoxElipseHeading(text: 'Mobile No'),
            DialogBoxText(
              text: mobileno,
            ),
            23.33.ph,
            DialogBoxElipseHeading(text: 'Expected Arrival Time'),
            DialogBoxText(
              text: Hour12formatTime(arrivaltime!),
            ),
            23.33.ph,
            DialogBoxElipseHeading(text: 'CNIC'),
            DialogBoxText(
              text: cnic ?? "",
            ),
            23.33.ph,
            DialogBoxElipseHeading(text: 'Expected Arrival Date'),
            DialogBoxText(text: laravelDateToFormattedDate(arrivaldate ?? "")),
            23.33.ph,
            MyButton(
              width: double.infinity,
              name: 'Okay',
              gradient: AppGradients.buttonGradient,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
