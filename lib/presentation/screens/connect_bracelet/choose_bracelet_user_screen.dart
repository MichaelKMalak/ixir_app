import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
              Text('Connect to a bracelet', style: AppStyles.header1WhiteText),
              const SizedBox(height: 26),
              Text('One more thing about you before connecting to a bracelet.', style: AppStyles.regularWhiteText),
              const SizedBox(height: 26),
              SvgPicture.asset(ImagePaths.braceletSvg),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      buttonLabel: "I'll be using the bracelet",
                      onClick: () => Navigator.pushNamed(
                          context, RoutePaths.connectOwnBraceletScreen,
                          arguments: braceletId),
                      buttonColorBt: AppColors.whiteColor,
                      labelColorBt: AppColors.blueColor,
                    ),
                    const SizedBox(height: 26),
                    CustomButton(
                      buttonLabel: 'Someone else will use the bracelet',
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
