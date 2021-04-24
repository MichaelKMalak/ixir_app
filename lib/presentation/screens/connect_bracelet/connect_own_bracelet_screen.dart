import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_const.dart';
import '../../../common.dart';
import '../../../domain/entities/bracelet_entity.dart';
import '../../bloc/connect_bracelet/connect_bracelet_cubit.dart';
import '../../navigation/route_paths.dart';
import '../../utils/string_utils.dart';
import '../../widgets/buttons/custom_button_widget.dart';
import '../../widgets/panel_over_scaffold.dart';
import '../../widgets/progress_widget.dart';
import '../../widgets/theme/app_colors.dart';
import '../../widgets/theme/app_dimensions.dart';
import '../../widgets/theme/app_styles.dart';

class ConnectOwnBraceletScreen extends StatelessWidget {
  final String braceletId;

  const ConnectOwnBraceletScreen({Key key, @required this.braceletId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PanelOverScaffold(
      topWidget: _TopWidget(braceletId: braceletId),
      bottomWidget: _BottomWidget(),
      backgroundColor: AppColors.greenColor,
    );
  }
}

class _TopWidget extends StatefulWidget {
  final String braceletId;

  const _TopWidget({Key key, this.braceletId}) : super(key: key);

  @override
  __TopWidgetState createState() => __TopWidgetState();
}

class __TopWidgetState extends State<_TopWidget> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String emergencyContact;
  double holderWeight;
  double holderHeight;
  String holderCardiovascularHistory = 'option-1';
  String holderBloodPressureHistory = 'option-3';
  String _countryCode = AppConst.defaultCountryCode.first;

  var _currencies = [
    "option-1",
    "option-2",
    "option-3",
    "option-4",
    "option-5",
  ];

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
      if (state is ConnectBraceletSuccess) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushNamedAndRemoveUntil(
            context, RoutePaths.homeScreen, (Route<dynamic> route) => false);
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
                AppLocalizations.of(context).yourHeightM,
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: AppStyles.getTextFieldInputStyle(
                    hintText: AppLocalizations.of(context).enterYourHeight),
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context).pleaseEnterYourHeight;
                  } else if (!StringUtils.isNumeric(value)) {
                    return AppLocalizations.of(context).pleaseEnterNumbersOnly;
                  } else if (double.parse(value) > 300 ||
                      double.parse(value) < 30) {
                    return AppLocalizations.of(context).pleaseEnterAValidNumber;
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    holderHeight = StringUtils.toDoubleWithDecimalPlaces(value);
                  });
                },
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context).yourWeightKg,
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: AppStyles.getTextFieldInputStyle(
                    hintText: AppLocalizations.of(context).enterYourWeight),
                validator: (value) {
                  if (value.isEmpty) {
                    return  AppLocalizations.of(context).pleaseEnterYourWeight;
                  } else if (!StringUtils.isNumeric(value)) {
                    return AppLocalizations.of(context).pleaseEnterNumbersOnly;
                  } else if (double.parse(value) > 400 ||
                      double.parse(value) < 30) {
                    return AppLocalizations.of(context).pleaseEnterAValidNumber;
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    holderWeight = StringUtils.toDoubleWithDecimalPlaces(value);
                  });
                },
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context).yourCardiovascularDiseaseHistory,
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: AppStyles.getTextFieldInputStyle(
                        hintText:
                            AppLocalizations.of(context).pleaseChooseAnOption),
                    isEmpty: holderCardiovascularHistory == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        dropdownColor: Colors.white,
                        value: holderCardiovascularHistory,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            holderCardiovascularHistory = newValue;
                            state.didChange(newValue);
                          });
                        },
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context).yourBloodPressureConditionHistory,
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: AppStyles.getTextFieldInputStyle(
                        hintText:
                            AppLocalizations.of(context).pleaseChooseAnOption),
                    isEmpty: holderBloodPressureHistory == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        dropdownColor: Colors.white,
                        value: holderBloodPressureHistory,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            holderBloodPressureHistory = newValue;
                            state.didChange(newValue);
                          });
                        },
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context).yourEmergencyContact,
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
                            hintText: 'Enter Emergency Contact Number'),
                        validator: (value) {
                          if (StringUtils.isEmpty(value)) {
                            return AppLocalizations.of(context)
                                .pleaseEnterEmergencyContactNumber;
                          }
                          if (!StringUtils.isPhoneNumber(value)) {
                            return AppLocalizations.of(context)
                                .pleaseEnterAValidPhoneNumber;
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            emergencyContact = _countryCode + value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              if (isLoading)
                ProgressWidget()
              else
                CustomButton(
                  buttonLabel: AppLocalizations.of(context).registerNewBracelet,
                  onClick: () async {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      await BlocProvider.of<ConnectBraceletCubit>(context)
                          .registerBracelet(
                              bracelet: BraceletEntity(
                                  isBraceletForOtherUser: false,
                                  id: widget.braceletId,
                                  holderEmergencyContact: emergencyContact,
                                  holderHeight: holderHeight,
                                  holderBloodPressureConditionHistory:
                                      holderBloodPressureHistory,
                                  holderCardiovascularDiseaseHistory:
                                      holderCardiovascularHistory,
                                  holderWeight: holderWeight));
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
