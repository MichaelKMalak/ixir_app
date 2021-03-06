import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common.dart';
import '../../../navigation/route_paths.dart';
import '../../../widgets/buttons/custom_button_widget.dart';
import '../../../widgets/image_paths.dart';
import '../../../widgets/logo_header_app_bar.dart';
import '../../../widgets/theme/app_colors.dart';
import '../../../widgets/theme/app_dimensions.dart';
import '../../../widgets/theme/app_styles.dart';

class SignUpLandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: AppDimensions.leftRightPagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const LogoHeaderAppBar(
                  textColor: AppColors.whiteColor,
                  backgroundColor: AppColors.greenColor,
                ),
                Text(AppLocalizations.of(context).welcome,
                    style: AppStyles.header1WhiteText),
                const SizedBox(height: 26),
                Text(
                    AppLocalizations.of(context)
                        .beforeYouGetGoingYouNeedToChooseYourPreferredMethodOfLoggingInTheFuture,
                    style: AppStyles.regularWhiteText),
                const SizedBox(height: 30),
                SvgPicture.asset(ImagePaths.braceletSvg),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        buttonLabel:
                            AppLocalizations.of(context).signUpWithEmailAddress,
                        onClick: () => Navigator.pushNamed(
                            context, RoutePaths.signUpEmailScreen),
                        buttonColorBt: AppColors.whiteColor,
                        labelColorBt: AppColors.blueColor,
                      ),
                      const SizedBox(height: 26),
                      CustomButton(
                        buttonLabel:
                            AppLocalizations.of(context).signUpWithMobileNumber,
                        onClick: () => Navigator.pushNamed(
                            context, RoutePaths.signUpPhoneScreen),
                        buttonColorBt: AppColors.whiteColor,
                        labelColorBt: AppColors.blueColor,
                      ),
                      const SizedBox(
                          height: AppDimensions.defaultBottomPaddingValue),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
