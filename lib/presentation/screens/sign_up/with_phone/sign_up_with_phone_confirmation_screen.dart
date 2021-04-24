import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../bloc/phone_auth/phone_auth_cubit.dart';
import '../../../navigation/route_paths.dart';
import '../../../widgets/buttons/custom_button_widget.dart';
import '../../../widgets/panel_over_scaffold.dart';
import '../../../widgets/progress_widget.dart';
import '../../../widgets/theme/app_colors.dart';
import '../../../widgets/theme/app_dimensions.dart';
import '../../../widgets/theme/app_styles.dart';

class SignUpWithPhoneConfirmationScreen extends StatelessWidget {
  final UserEntity newUser;

  const SignUpWithPhoneConfirmationScreen({Key key, this.newUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PanelOverScaffold(
        overflows: false,
        appBarTextColor: AppColors.blueColor,
        topWidget: _TopWidget(newUser: newUser),
        bottomWidget: _BottomWidget(),
        backgroundColor: AppColors.yellowColor);
  }
}

class _TopWidget extends StatefulWidget {
  final UserEntity newUser;

  const _TopWidget({Key key, this.newUser}) : super(key: key);

  @override
  __TopWidgetState createState() => __TopWidgetState();
}

class __TopWidgetState extends State<_TopWidget> {
  final formKey = GlobalKey<FormState>();
  String smsCode;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
        listener: (context, phoneAuthState) {
      if (phoneAuthState is PhoneAuthSuccess) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushNamed(context, RoutePaths.signInScreen);
      }
      if (phoneAuthState is PhoneAuthLoading) {
        setState(() {
          isLoading = true;
        });
      }
      if (phoneAuthState is PhoneAuthFailure) {
        setState(() {
          isLoading = false;
        });
      }
    }, builder: (context, phoneAuthState) {
      return Form(
        key: formKey,
        child: Padding(
          padding: AppDimensions.leftRightPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).verificationCode,
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: AppStyles.getTextFieldInputStyle(
                    hintText:
                        AppLocalizations.of(context).enterVerificationCode),
                validator: (value) {
                  if (value.isEmpty || value.length != 6) {
                    return AppLocalizations.of(context)
                        .pleaseEnterAValidVerificationCode;
                  }
                  return null;
                },
                onSaved: (value) => setState(() => smsCode = value),
              ),
              const SizedBox(height: 30),
              if (isLoading)
                ProgressWidget()
              else
                CustomButton(
                  buttonLabel: AppLocalizations.of(context).confirm,
                  onClick: () {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      BlocProvider.of<PhoneAuthCubit>(context).submitSmsCode(
                          userEntity: widget.newUser, smsCode: smsCode);
                    }
                  },
                  buttonColorBt: AppColors.blueColor,
                  labelColorBt: AppColors.whiteColor,
                ),
              const SizedBox(height: 10),
              if (isLoading)
                const SizedBox.shrink()
              else
                TextButton(
                    onPressed: () => BlocProvider.of<PhoneAuthCubit>(context)
                        .resendPhoneVerificationUseCase(
                            widget.newUser.phoneNumber),
                    child: Text(
                      AppLocalizations.of(context).resendVerificationSms,
                      style: AppStyles.regularPrimaryText.copyWith(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    )),
              const SizedBox(height: AppDimensions.defaultBottomPaddingValue),
            ],
          ),
        ),
      );
    });
  }
}

class _BottomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.leftRightPagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context).weSentYouAVerificationSms,
            style: AppStyles.header1Primary,
          ),
          const SizedBox(height: 26),
          Text(
            AppLocalizations.of(context)
                .weSendYouAMessageToYourPhoneWithAVerificationCodeIfYouDidntGetItItsOkayYouCanAlwaysResendIt,
            style: AppStyles.regularPrimaryText,
          ),
          const SizedBox(height: 150),
        ],
      ),
    );
  }
}
