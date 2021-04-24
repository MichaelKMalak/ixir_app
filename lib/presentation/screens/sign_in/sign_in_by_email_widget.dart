import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common.dart';
import '../../bloc/email_auth/email_auth_cubit.dart';
import '../../navigation/route_paths.dart';
import '../../utils/string_utils.dart';
import '../../widgets/buttons/custom_button_widget.dart';
import '../../widgets/progress_widget.dart';
import '../../widgets/theme/app_colors.dart';
import '../../widgets/theme/app_dimensions.dart';
import '../../widgets/theme/app_styles.dart';

class SignInByEmailWidget extends StatefulWidget {
  @override
  SignInByEmailWidgetState createState() => SignInByEmailWidgetState();
}

class SignInByEmailWidgetState extends State<SignInByEmailWidget> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String password;
  String email;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmailAuthCubit, EmailAuthState>(
        listener: (context, emailAuthState) {
      if (emailAuthState is EmailAuthFailure) {
        setState(() {
          isLoading = false;
        });
      }
      if (emailAuthState is EmailAuthLoading) {
        setState(() {
          isLoading = true;
        });
      }
      if (emailAuthState is EmailAuthSuccess) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushNamedAndRemoveUntil(
            context, RoutePaths.splashScreen, (Route<dynamic> route) => false);
      }
    }, builder: (context, emailAuthState) {
      return Form(
        key: formKey,
        child: Padding(
          padding: AppDimensions.leftRightPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).emailAddress,
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              TextFormField(
                decoration: AppStyles.getTextFieldInputStyle(
                    hintText:
                        AppLocalizations.of(context).enterYourEmailAddress),
                validator: (value) {
                  if (StringUtils.isEmpty(value)) {
                    return AppLocalizations.of(context)
                        .pleaseEnterYourEmailAddress;
                  }
                  if (!StringUtils.isEmail(value)) {
                    return AppLocalizations.of(context)
                        .pleaseEnterAValidEmailAddress;
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              Text(
                password,
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              TextFormField(
                decoration: AppStyles.getTextFieldInputStyle(
                    hintText: AppLocalizations.of(context).enterYourPassword),
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context).pleaseEnterYourPassword;
                  } else if (value.length < 8) {
                    return AppLocalizations.of(context)
                        .pleaseEnterAPasswordWithAtLeast8Characters;
                  }
                  setState(() {
                    password = value;
                  });
                  return null;
                },
              ),
              const SizedBox(height: 30),
              if (isLoading)
                ProgressWidget()
              else
                CustomButton(
                  buttonLabel: AppLocalizations.of(context).signIn,
                  onClick: () async {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      await BlocProvider.of<EmailAuthCubit>(context)
                          .signInWithEmail(email: email, password: password);
                    }
                  },
                  buttonColorBt: AppColors.blueColor,
                  labelColorBt: AppColors.whiteColor,
                ),
              const SizedBox(height: AppDimensions.defaultBottomPaddingValue),
            ],
          ),
        ),
      );
    });
  }
}
