import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

import 'base_button_widget.dart';

class CustomButton extends BaseButton {
  final String buttonLabel;
  final void Function() onClick;
  final IconData icon;
  final bool isEnable;
  final Color borderColorBt;
  final Color buttonColorBt;
  final Color buttonDisabledColorBt;
  final Color labelColorBt;
  final Color labelDisabledColorBt;

  const CustomButton(
      {@required this.buttonLabel,
      @required this.onClick,
      this.buttonColorBt = AppColors.transparent,
      this.labelColorBt = AppColors.transparent,
      this.borderColorBt = AppColors.greyColor,
      this.buttonDisabledColorBt = AppColors.greyColor,
      this.labelDisabledColorBt = AppColors.whiteColor,
      this.isEnable = true,
      this.icon,
      Key key})
      : super(
            buttonColor: buttonColorBt,
            buttonDisabledColor: buttonDisabledColorBt,
            borderColor: borderColorBt ?? buttonColorBt,
            borderDisabledColor: borderColorBt,
            labelColor: labelColorBt,
            labelDisabledColor: labelDisabledColorBt,
            labelBt: buttonLabel,
            onClickBt: onClick,
            iconBt: icon,
            isEnableBt: isEnable,
            key: key);
}
