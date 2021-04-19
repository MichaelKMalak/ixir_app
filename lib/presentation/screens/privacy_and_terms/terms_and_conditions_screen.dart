import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

import '../../navigation/route_paths.dart';
import '../../widgets/buttons/custom_button_widget.dart';
import '../../widgets/theme/app_colors.dart';
import '../../widgets/theme/app_dimensions.dart';
import '../../widgets/theme/app_styles.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms and Conditions',
          style: AppStyles.header1Primary.copyWith(color: AppColors.blackColor),
        ),
        brightness: Brightness.light,
      ),
      body: ListView(
        padding: AppDimensions.leftRightPagePadding,
        children: [
          Text(
            loremIpsum(paragraphs: 10, words: 700),
            style: AppStyles.regularPrimaryText
                .copyWith(color: AppColors.blackColor),
          ),
          const SizedBox(height: 50),
          CustomButton(
            buttonLabel: 'I have read and I agree',
            buttonColorBt: AppColors.blueColor,
            labelColorBt: AppColors.whiteColor,
            onClick: () =>
                Navigator.pushNamed(context, RoutePaths.signUpLandingScreen),
          ),
          const SizedBox(height: 70),
        ],
      ),
    );
  }
}
