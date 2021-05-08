import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common.dart';
import '../../bloc/auth/auth_cubit.dart';
import '../../bloc/connect_bracelet/connect_bracelet_cubit.dart';
import '../../navigation/route_paths.dart';
import '../../widgets/buttons/custom_button_widget.dart';
import '../../widgets/panel_over_scaffold.dart';
import '../../widgets/progress_widget.dart';
import '../../widgets/theme/app_colors.dart';
import '../../widgets/theme/app_dimensions.dart';
import '../../widgets/theme/app_styles.dart';

class EnterBraceletSerialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PanelOverScaffold(
      overflows: false,
      topWidget: _TopWidget(),
      bottomWidget: _BottomWidget(),
      backgroundColor: AppColors.greenColor,
    );
  }
}

class _TopWidget extends StatefulWidget {
  @override
  __TopWidgetState createState() => __TopWidgetState();
}

class __TopWidgetState extends State<_TopWidget> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String braceletId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectBraceletCubit, ConnectBraceletState>(
        listener: (context, state) {
      if (state is ConnectBraceletFailure) {
        setState(() {
          isLoading = false;
        });
      }
      if (state is ConnectBraceletLoading) {
        setState(() {
          isLoading = true;
        });
      }
      if (state is ConnectBraceletSerialConfirmed) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushNamed(context, RoutePaths.chooseBraceletUserScreen,
            arguments: braceletId);
      }
    }, builder: (context, state) {
      return Form(
        key: formKey,
        child: Padding(
          padding: AppDimensions.leftRightPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).braceletSerialNumber,
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: AppStyles.getTextFieldInputStyle(
                    hintText: AppLocalizations.of(context)
                        .enterYourBraceletSerialNumber),
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context)
                        .pleaseEnterYourBraceletSerialNumber;
                  }

                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    braceletId = value;
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
                      await BlocProvider.of<ConnectBraceletCubit>(context)
                          .isBraceletIdValid(braceletId: braceletId);
                    }
                  },
                  buttonColorBt: AppColors.blueColor,
                  labelColorBt: AppColors.whiteColor,
                ),
              const SizedBox(height: 26),
              CustomButton(
                buttonLabel:
                    AppLocalizations.of(context).cantFindTheSerialNumber,
                onClick: () {},
                labelColorBt: AppColors.blueColor,
                borderColorBt: AppColors.blueColor,
              ),
              const SizedBox(height: 26),
              CustomButton(
                buttonLabel: AppLocalizations.of(context).logout,
                onClick: () async {
                  await BlocProvider.of<AuthCubit>(context).logOut();
                },
                labelColorBt: AppColors.blueColor,
                borderColorBt: AppColors.blueColor,
              ),
              const SizedBox(height: 26),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    AppLocalizations.of(context).cantFindTheSerialNumber,
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
            AppLocalizations.of(context).connectToABracelet,
            style: AppStyles.header1WhiteText,
          ),
          const SizedBox(height: 26),
          Text(
            AppLocalizations.of(context)
                .youWillFindASerialNumberPrintedOnIxirHealthMonitoringBraceletToConnectItWithYourAccountPleaseEnterThisSerialNumberBelow,
            style: AppStyles.regularWhiteText,
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
