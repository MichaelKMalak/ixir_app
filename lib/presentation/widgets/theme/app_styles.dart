import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyles {
  static const TextStyle inputLabelTextStyle = TextStyle(
    color: AppColors.blackColor,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle regularPrimaryText = TextStyle(
      color: AppColors.blueColor, fontSize: 15, fontWeight: FontWeight.normal);

  static TextStyle regularWhiteText =
      regularPrimaryText.copyWith(color: AppColors.whiteColor);

  static const TextStyle header1Primary = TextStyle(
      color: AppColors.blueColor, fontSize: 26, fontWeight: FontWeight.bold);

  static TextStyle header1WhiteText =
      header1Primary.copyWith(color: AppColors.whiteColor);

  static InputDecoration getTextFieldInputStyle({String hintText = ''}) {
    const double _borderRadius = 10;
    return InputDecoration(
      filled: true,
      fillColor: AppColors.whiteColor,
      hintText: hintText,
      hintStyle: const TextStyle(color: AppColors.greyColor),
      contentPadding:
          const EdgeInsets.only(left: 22, right: 24, bottom: 17, top: 17),
      focusColor: AppColors.blueColor,
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.blueColor),
        borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.redColor),
        borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.blueColor),
        borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.greyColor, width: 1.6),
        borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
      ),
    );
  }
}
