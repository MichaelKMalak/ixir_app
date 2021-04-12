import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ixir_app/presentation/navigation/route_paths.dart';
import 'package:ixir_app/presentation/widgets/buttons/custom_button_widget.dart';
import 'package:ixir_app/presentation/widgets/image_paths.dart';
import 'package:ixir_app/presentation/widgets/logo_header_app_bar.dart';
import 'package:ixir_app/presentation/widgets/theme/app_colors.dart';
import 'package:ixir_app/presentation/widgets/theme/app_dimensions.dart';
import 'package:ixir_app/presentation/widgets/theme/app_styles.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

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
                Text('Welcome!', style: AppStyles.header1WhiteText),
                const SizedBox(height: 26),
                Text(
                    'Before you get going, you need to choose your preferred method of logging in the future. ',
                    style: AppStyles.regularWhiteText),
                const SizedBox(height: 30),
                SvgPicture.asset(ImagePaths.braceletSvg),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        buttonLabel: 'Sign up with Email Address',
                        onClick: () => Navigator.pushNamed(
                            context, RoutePaths.signUpEmailScreen),
                        buttonColorBt: AppColors.whiteColor,
                        labelColorBt: AppColors.blueColor,
                      ),
                      const SizedBox(height: 26),
                      CustomButton(
                        buttonLabel: 'Sign up with Mobile Number',
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
