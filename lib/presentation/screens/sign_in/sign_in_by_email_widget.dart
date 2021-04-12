import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ixir_app/presentation/bloc/email_auth/email_auth_cubit.dart';
import 'package:ixir_app/presentation/navigation/route_paths.dart';
import 'package:ixir_app/presentation/utils/string_utils.dart';
import 'package:ixir_app/presentation/widgets/buttons/custom_button_widget.dart';
import 'package:ixir_app/presentation/widgets/progress_widget.dart';
import 'package:ixir_app/presentation/widgets/theme/app_colors.dart';
import 'package:ixir_app/presentation/widgets/theme/app_dimensions.dart';
import 'package:ixir_app/presentation/widgets/theme/app_styles.dart';

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
                'Email Address',
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              TextFormField(
                decoration: AppStyles.getTextFieldInputStyle(
                    hintText: 'Enter your Email Address'),
                validator: (value) {
                  if (StringUtils.isEmpty(value)) {
                    return 'Please enter your Email Address';
                  }
                  if (!StringUtils.isEmail(value)) {
                    return 'Please enter a valid Email Address';
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
