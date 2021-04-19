import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_const.dart';
import '../../bloc/email_auth/email_auth_cubit.dart';
import '../../navigation/route_paths.dart';
import '../../utils/string_utils.dart';
import '../../widgets/buttons/custom_button_widget.dart';
import '../../widgets/progress_widget.dart';
import '../../widgets/theme/app_colors.dart';
import '../../widgets/theme/app_dimensions.dart';
import '../../widgets/theme/app_styles.dart';

class SignInByPhoneWidget extends StatefulWidget {
  @override
  SignInByPhoneWidgetState createState() => SignInByPhoneWidgetState();
}

class SignInByPhoneWidgetState extends State<SignInByPhoneWidget> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String password;
  String phoneNumber;
  String _countryCode = AppConst.defaultCountryCode.first;

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
                'Phone Number',
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CountryCodePicker(
                      onChanged: (countryCode) {
                        setState(() {
                          _countryCode = countryCode.dialCode;
                        });
                      },
                      initialSelection: AppConst.defaultCountryCode.last,
                      favorite: AppConst.defaultCountryCode,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: AppStyles.getTextFieldInputStyle(
                            hintText: 'Enter your Phone Number'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your Phone Number';
                          }
                          if (!StringUtils.isPhoneNumber(value)) {
                            return 'Please enter a valid Phone Number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            phoneNumber = _countryCode + value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Password',
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              TextFormField(
                decoration: AppStyles.getTextFieldInputStyle(
                    hintText: 'Enter your Password'),
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your Password';
                  } else if (value.length < 8) {
                    return 'Please enter a Password with at least 8 characters';
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
                  buttonLabel: 'Sign in',
                  onClick: () async {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      await BlocProvider.of<EmailAuthCubit>(context)
                          .signInWithEmail(
                          email: phoneNumber, password: password);
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