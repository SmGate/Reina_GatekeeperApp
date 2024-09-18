import 'package:flutter/material.dart';
import 'package:gatekeeper/utils/styles/colors.dart';

class AppGradients {
  // Define the colors used in the gradient
  static const Color gradientYellow = Color.fromRGBO(247, 240, 182, 1.0);
  static const Color gradientTint = Color.fromRGBO(223, 239, 234, 1.0);

  // Define the horizontal gradient
  static const LinearGradient horizontalGradient = LinearGradient(
    colors: [
      gradientYellow,
      gradientTint,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static LinearGradient buttonGradient = LinearGradient(
    colors: [
      AppColors.yellow,
      AppColors.appThem.withOpacity(0.5),
    ],
    begin: Alignment.topCenter,
    end: Alignment.centerRight,
  );

  static LinearGradient floatingbuttonGradient = LinearGradient(
    colors: [
      AppColors.appThem.withOpacity(0.6),
      AppColors.yellow,
    ],
    begin: Alignment.topCenter,
    end: Alignment.centerRight,
  );
}
