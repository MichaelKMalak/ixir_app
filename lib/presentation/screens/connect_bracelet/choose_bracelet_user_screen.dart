import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common.dart';
import '../../navigation/route_paths.dart';
import '../../widgets/buttons/custom_button_widget.dart';
import '../../widgets/image_paths.dart';
import '../../widgets/logo_header_app_bar.dart';
import '../../widgets/theme/app_colors.dart';
import '../../widgets/theme/app_dimensions.dart';
import '../../widgets/theme/app_styles.dart';

class ChooseBraceletUserScreen extends StatelessWidget {
  final String braceletId;

  const ChooseBraceletUserScreen({Key key, @required this.braceletId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenColor,
      body: SafeArea(
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
              Text(AppLocalizations.of(context).connectToABracelet,
                  style: AppStyles.header1WhiteText),
              const SizedBox(height: 26),
              Text(
                  AppLocalizations.of(context)
                      .oneMoreThingAboutYouBeforeConnectingToABracelet,
                  style: AppStyles.regularWhiteText),
              const SizedBox(height: 26),
              SvgPicture.asset(ImagePaths.braceletSvg),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      buttonLabel:
                          AppLocalizations.of(context).illBeUsingTheBracelet,
                      onClick: () => Navigator.pushNamed(
                          context, RoutePaths.connectOwnBraceletScreen,
                          arguments: braceletId),
                      buttonColorBt: AppColors.whiteColor,
                      labelColorBt: AppColors.blueColor,
                    ),
                    const SizedBox(height: 26),
                    CustomButton(
                      buttonLabel: AppLocalizations.of(context)
                          .someoneElseWillUseTheBracelet,
                      onClick: () => Navigator.pushNamed(
                          context, RoutePaths.connectOtherPersonBraceletScreen,
                          arguments: braceletId),
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
    );
  }
}
