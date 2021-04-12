import 'package:flutter/material.dart';
import 'package:ixir_app/presentation/navigation/route_paths.dart';
import 'package:ixir_app/presentation/widgets/buttons/custom_button_widget.dart';
import 'package:ixir_app/presentation/widgets/theme/app_colors.dart';
import 'package:ixir_app/presentation/widgets/theme/app_styles.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

import '../../widgets/theme/app_dimensions.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
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
            onClick: () => Navigator.pushNamed(
                context, RoutePaths.termsAndConditionsScreen),
          ),
          const SizedBox(height: 70),
        ],
      ),
    );
  }
}
