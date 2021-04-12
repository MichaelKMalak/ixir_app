import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ixir_app/presentation/widgets/image_paths.dart';

import '../../../bloc/email_auth/email_auth_cubit.dart';
import '../../../navigation/route_paths.dart';
import '../../../widgets/buttons/custom_button_widget.dart';
import '../../../widgets/logo_header_app_bar.dart';
import '../../../widgets/theme/app_colors.dart';
import '../../../widgets/theme/app_dimensions.dart';
import '../../../widgets/theme/app_styles.dart';

class SignUpWithEmailConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlueColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: AppDimensions.leftRightPagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const LogoHeaderAppBar(
                  textColor: AppColors.blueColor,
                  backgroundColor: AppColors.lightBlueColor,
                ),
                Text(
                  'We sent you an email',
                  style: AppStyles.header1Primary,
                ),
                const SizedBox(height: 26),
                Text(
                  'We sent you an email to verify your account. Please check your inbox and your spam folder. If you didn’t get it, it’s okay, you can always resend it.',
                  style: AppStyles.regularPrimaryText,
                ),
                const SizedBox(height: 26),
                SvgPicture.asset(ImagePaths.emailSentSvg),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        buttonLabel: 'Log in',
                        onClick: () => Navigator.pushNamed(
                            context, RoutePaths.signInScreen),
                        buttonColorBt: AppColors.blueColor,
                        labelColorBt: AppColors.whiteColor,
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                          onPressed: () async {
                            await BlocProvider.of<EmailAuthCubit>(context)
                                .sendEmailVerificationUseCase();
                          },
                          child: Text(
                            'Resend Verification Email',
                            style: AppStyles.regularPrimaryText.copyWith(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          )),
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
