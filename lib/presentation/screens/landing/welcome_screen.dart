import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common.dart';
import '../../navigation/route_paths.dart';
import '../../widgets/buttons/custom_button_widget.dart';
import '../../widgets/image_paths.dart';
import '../../widgets/logo_header_app_bar.dart';
import '../../widgets/theme/app_colors.dart';
import '../../widgets/theme/app_dimensions.dart';
import '../../widgets/theme/app_styles.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlueColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          bottom: false,
          child: Stack(children: [
            _Background(),
            _Foreground(),
          ]),
        ),
      ),
    );
  }
}

class _Foreground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.leftRightPagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const LogoHeaderAppBar(
            textColor: AppColors.blueColor,
            backgroundColor: AppColors.lightBlueColor,
            forceHideBackButton: true,
          ),
          Text(
            AppLocalizations.of(context)
                .experienceTheHighestQualityCareForSeniors,
            style: AppStyles.header1Primary,
          ),
          Column(
            children: [
              SvgPicture.asset(ImagePaths.landingDoctorSvg),
              const SizedBox(height: 15),
              Padding(
                padding: AppDimensions.wideLeftRightPagePadding,
                child: Text(
                  AppLocalizations.of(context)
                      .ourArtificialIntelligenceSensorsAreAutomaticallySetToMonitorAndDetectAbnormalitiesInHealth,
                  style: AppStyles.regularWhiteText,
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  buttonLabel: AppLocalizations.of(context).signUp,
                  onClick: () => Navigator.pushNamed(
                      context, RoutePaths.privacyPolicyScreen),
                  buttonColorBt: AppColors.whiteColor,
                  labelColorBt: AppColors.blueColor,
                ),
                const SizedBox(height: 26),
                CustomButton(
                  buttonLabel: AppLocalizations.of(context).alreadyAMemberLogIn,
                  onClick: () =>
                      Navigator.pushNamed(context, RoutePaths.signInScreen),
                  labelColorBt: AppColors.whiteColor,
                  borderColorBt: AppColors.whiteColor,
                ),
                const SizedBox(height: AppDimensions.defaultBottomPaddingValue),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Column(
        children: [
          Container(
            color: AppColors.lightBlueColor,
            height: constraints.maxHeight * 0.35,
          ),
          Container(
            color: AppColors.blueColor,
            height: constraints.maxHeight * 0.65,
          ),
        ],
      );
    });
  }
}
