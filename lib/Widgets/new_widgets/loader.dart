import 'package:flutter/material.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:get/get.dart';

class Loader extends GetView {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: CircularProgressIndicator(
            color: AppColors.appThem,
          )),
        ],
      ),
    );
  }
}
