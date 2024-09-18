import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomDialog extends StatelessWidget {
  final String? title, content, positiveBtnText, negativeBtnText;
  final GestureTapCallback? positiveBtnPressed;
  final GestureTapCallback? negativeBtnPressed;
  final Widget? image;
  final bool loading;

  CustomDialog({
    this.image,
    this.title,
    this.content,
    this.positiveBtnText,
    this.negativeBtnText,
    this.positiveBtnPressed,
    this.negativeBtnPressed,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 2,
          // Bottom rectangular box
          margin:
              EdgeInsets.only(top: 24), // to push the box half way below circle
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.only(
              top: 60, left: 20, right: 20), // spacing inside the box
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title ?? '',
                style: GoogleFonts.montserrat(
                    color: HexColor('#4D4D4D'), fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                content ?? '',
                style: GoogleFonts.montserrat(
                    color: HexColor('#4D4D4D'), fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                buttonMinWidth: 100,
                children: <Widget>[
                  loading
                      ? Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: SizedBox(
                              height: 20,
                              width: 20,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.appThem,
                                ),
                              )),
                        )
                      : GestureDetector(
                          onTap: positiveBtnPressed,
                          child: Container(
                            child: Center(
                                child: Text(
                              positiveBtnText!,
                              style: GoogleFonts.ubuntu(
                                  color: HexColor(
                                    '#FFFFFF',
                                  ),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400),
                            )),
                            width: 66.w,
                            height: 20.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.r),
                                color: HexColor('#4EC018')),
                          )),
                  GestureDetector(
                      onTap: negativeBtnPressed,
                      child: Container(
                        child: Center(
                            child: Text(
                          negativeBtnText!,
                          style: GoogleFonts.ubuntu(
                              color: HexColor(
                                '#263238',
                              ),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400),
                        )),
                        width: 66.w,
                        height: 20.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.r),
                            color: HexColor('#E4E4E4')),
                      )),
                ],
              ),
            ],
          ),
        ),
        CircleAvatar(
          backgroundColor: AppColors.appThem,
          // Top Circle with icon
          maxRadius: 30.0,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: image,
          ),
        ),
      ],
    );
  }
}
