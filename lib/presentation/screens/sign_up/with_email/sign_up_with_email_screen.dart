import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../bloc/email_auth/email_auth_cubit.dart';
import '../../../navigation/route_paths.dart';
import '../../../utils/string_utils.dart';
import '../../../widgets/buttons/custom_button_widget.dart';
import '../../../widgets/panel_over_scaffold.dart';
import '../../../widgets/progress_widget.dart';
import '../../../widgets/theme/app_colors.dart';
import '../../../widgets/theme/app_dimensions.dart';
import '../../../widgets/theme/app_styles.dart';

class SignUpWithEmailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PanelOverScaffold(
        topWidget: _TopWidget(),
        bottomWidget: _BottomWidget(),
        backgroundColor: AppColors.blueColor);
  }
}

class _TopWidget extends StatefulWidget {
  @override
  __TopWidgetState createState() => __TopWidgetState();
}

class __TopWidgetState extends State<_TopWidget> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String password;
  String firstName;
  String lastName;
  String email;
  DateTime dateOfBirth = DateTime(1990);

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
                AppLocalizations.of(context).firstName,
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: AppStyles.getTextFieldInputStyle(
                    hintText: AppLocalizations.of(context).enterYourFirstName),
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context)
                        .pleaseEnterYourFirstName;
                  } else if (value.length < 2 ||
                      StringUtils.hasNonAlphabet(value)) {
                    return AppLocalizations.of(context)
                        .pleaseEnterAValidFirstName;
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    firstName = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context).lastName,
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: AppStyles.getTextFieldInputStyle(
                    hintText: AppLocalizations.of(context).enterYourLastName),
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context).pleaseEnterYourLastName;
                  } else if (value.length < 2 ||
                      StringUtils.hasNonAlphabet(value)) {
                    return AppLocalizations.of(context)
                        .pleaseEnterAValidLastName;
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    lastName = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context).emailAddress,
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
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
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context).passwordConfirmation,
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              TextFormField(
                decoration: AppStyles.getTextFieldInputStyle(
                    hintText: AppLocalizations.of(context)
                        .enterYourPasswordConfirmation),
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context)
                        .pleaseEnterYourPasswordConfirmation;
                  } else if (value != password) {
                    return AppLocalizations.of(context)
                        .pleaseMakeSurePasswordsAreMatching;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context).dateOfBirth,
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              DateTimeFormField(
                initialValue: dateOfBirth,
                decoration: AppStyles.getTextFieldInputStyle(
                    hintText:
                        AppLocalizations.of(context).enterYourDateOfBirth),
                mode: DateTimeFieldPickerMode.date,
                validator: (e) => (e?.year == null ||
                        e.year > 2010 ||
                        e.year < 1900)
                    ? AppLocalizations.of(context).pleaseEnterAValidDateOfBirth
                    : null,
                autovalidateMode: AutovalidateMode.always,
                onSaved: (value) {
                  setState(() {
                    dateOfBirth = value;
                  });
                },
              ),
              const SizedBox(height: 30),
              if (isLoading)
                ProgressWidget()
              else
                CustomButton(
                  buttonLabel: AppLocalizations.of(context).submit,
                  onClick: () async {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      await BlocProvider.of<EmailAuthCubit>(context)
                          .signUpWithEmail(
                        user: UserEntity(
                            dateOfBirth: dateOfBirth,
                            firstName: firstName,
                            lastName: lastName,
                            email: email,
                            password: password),
                      );
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

class _BottomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.leftRightPagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context).almostThere,
            style: AppStyles.header1WhiteText,
          ),
          const SizedBox(height: 26),
          Text(
            AppLocalizations.of(context)
                .onceYouFinishThisFormYourAccountWillBeSetAndYouWillBeAbleToConnectYourBracelet,
            style: AppStyles.regularWhiteText,
          ),
          const SizedBox(height: 35),
        ],
      ),
    );
  }
}
