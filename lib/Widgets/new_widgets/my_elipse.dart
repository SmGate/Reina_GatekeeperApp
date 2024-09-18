import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gatekeeper/utils/styles/colors.dart';

class MyElipse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,
      child: Container(
        width: 16.w,
        height: 16.w,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: AppColors.appThem),
      ),
    );
  }
}
