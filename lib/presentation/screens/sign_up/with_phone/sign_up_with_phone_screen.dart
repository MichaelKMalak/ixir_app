import 'package:country_code_picker/country_code_picker.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app_const.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../bloc/phone_auth/phone_auth_cubit.dart';
import '../../../navigation/route_paths.dart';
import '../../../utils/string_utils.dart';
import '../../../widgets/buttons/custom_button_widget.dart';
import '../../../widgets/panel_over_scaffold.dart';
import '../../../widgets/progress_widget.dart';
import '../../../widgets/theme/app_colors.dart';
import '../../../widgets/theme/app_dimensions.dart';
import '../../../widgets/theme/app_styles.dart';

class SignUpWithPhoneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PanelOverScaffold(
      topWidget: _TopWidget(),
      bottomWidget: _BottomWidget(),
      backgroundColor: AppColors.blueColor,
    );
  }
}

class _TopWidget extends StatefulWidget {
  @override
  __TopWidgetState createState() => __TopWidgetState();
}

class __TopWidgetState extends State<_TopWidget> {
  final formKey = GlobalKey<FormState>();
  String _countryCode = AppConst.defaultCountryCode.first;
  bool isLoading = false;

  String password;
  String firstName;
  String lastName;
  String phoneNumber;
  DateTime dateOfBirth = DateTime(1990);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
        listener: (context, phoneAuthState) {
      if (phoneAuthState is PhoneAuthFailure) {
        setState(() {
          isLoading = false;
        });
      }
      if (phoneAuthState is PhoneAuthLoading) {
        setState(() {
          isLoading = true;
        });
      }
      if (phoneAuthState is PhoneAuthSmsCodeReceived) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushNamed(
          context,
          RoutePaths.signUpPhoneConfirmationScreen,
          arguments: UserEntity(
              dateOfBirth: dateOfBirth,
              firstName: firstName,
              lastName: lastName,
              phoneNumber: phoneNumber,
              password: password),
        );
      }
    }, builder: (context, phoneAuthState) {
      return Form(
        key: formKey,
        child: Padding(
          padding: AppDimensions.leftRightPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'First Name',
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: AppStyles.getTextFieldInputStyle(
                    hintText: 'Enter your first name'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your first name';
                  } else if (value.length < 2 ||
                      StringUtils.hasNonAlphabet(value)) {
                    return 'Please enter a valid first name';
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
                'Last Name',
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: AppStyles.getTextFieldInputStyle(
                    hintText: 'Enter your last name'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your last name';
                  } else if (value.length < 2 ||
                      StringUtils.hasNonAlphabet(value)) {
                    return 'Please enter a valid last name';
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
              const SizedBox(height: 20),
              Text(
                'Password Confirmation',
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              TextFormField(
                decoration: AppStyles.getTextFieldInputStyle(
                    hintText: 'Enter your Password Confirmation'),
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your Password Confirmation';
                  } else if (value != password) {
                    return 'Please make sure passwords are matching';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Date of Birth',
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              DateTimeFormField(
                initialValue: dateOfBirth,
                decoration: AppStyles.getTextFieldInputStyle(
                    hintText: 'Enter your Date of Birth'),
                mode: DateTimeFieldPickerMode.date,
                validator: (e) =>
                    (e?.year == null || e?.year > 2010 || e?.year < 1900)
                        ? 'Please enter a valid date of birth'
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
                  buttonLabel: 'Submit',
                  onClick: () async {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      await BlocProvider.of<PhoneAuthCubit>(context)
                          .signUpWithPhoneNumber(
                        phoneNumber: phoneNumber,
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
            'Almost there!',
            style: AppStyles.header1WhiteText,
          ),
          const SizedBox(height: 26),
          Text(
            'Once you finish this form, your account will be set and you will be able to connect your bracelet.',
            style: AppStyles.regularWhiteText,
          ),
          const SizedBox(height: 35),
        ],
      ),
    );
  }
}
