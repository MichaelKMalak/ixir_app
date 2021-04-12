import 'package:country_code_picker/country_code_picker.dart';
import 'package:date_field/date_field.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ixir_app/presentation/bloc/connect_bracelet/connect_bracelet_cubit.dart';
import 'package:ixir_app/presentation/navigation/route_paths.dart';
import 'package:ixir_app/presentation/utils/string_utils.dart';
import 'package:ixir_app/presentation/widgets/buttons/custom_button_widget.dart';
import 'package:ixir_app/presentation/widgets/panel_over_scaffold.dart';
import 'package:ixir_app/domain/entities/bracelet_entity.dart';
import 'package:ixir_app/presentation/widgets/progress_widget.dart';
import 'package:ixir_app/presentation/widgets/theme/app_colors.dart';
import 'package:ixir_app/presentation/widgets/theme/app_dimensions.dart';
import 'package:ixir_app/presentation/widgets/theme/app_styles.dart';

import '../../../app_const.dart';

class ConnectOtherPersonBraceletScreen extends StatelessWidget {
  final String braceletId;

  const ConnectOtherPersonBraceletScreen({Key key, @required this.braceletId})
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
  String holderFirstName;
  String holderLastName;
  String emergencyContact;
  double holderWeight;
  double holderHeight;
  String holderCardiovascularHistory = 'option-1';
  String holderBloodPressureHistory = 'option-3';
  DateTime holderDateOfBirth = DateTime(1970);
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
                'Bracelet Holder First Name',
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: AppStyles.getTextFieldInputStyle(
                    hintText: 'Enter Bracelet Holder first name'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter bracelet holder first name';
                  } else if (value.length < 2 ||
                      StringUtils.hasNonAlphabet(value)) {
                    return 'Please enter a valid name';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    holderFirstName = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Bracelet Holder Last Name',
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: AppStyles.getTextFieldInputStyle(
                    hintText: 'Enter Bracelet Holder last name'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter bracelet holder last name';
                  } else if (value.length < 2 ||
                      StringUtils.hasNonAlphabet(value)) {
                    return 'Please enter a valid name';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    holderLastName = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Date of Birth',
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              DateTimeFormField(
                initialValue: holderDateOfBirth,
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
                    holderDateOfBirth = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Bracelet Holder Height (m)',
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: AppStyles.getTextFieldInputStyle(
                    hintText: 'Enter Bracelet Holder Height'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter bracelet holder height';
                  } else if (!StringUtils.isNumeric(value)) {
                    return 'Please enter numbers only';
                  } else if (double.parse(value) > 300 ||
                      double.parse(value) < 30) {
                    return 'Please enter a valid number';
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
                'Bracelet Holder Weight (Kg)',
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: AppStyles.getTextFieldInputStyle(
                    hintText: 'Enter Bracelet Weight'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter bracelet holder weight';
                  } else if (!StringUtils.isNumeric(value)) {
                    return 'Please enter numbers only';
                  } else if (double.parse(value) > 400 ||
                      double.parse(value) < 30) {
                    return 'Please enter a valid number';
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
                "Bracelet Holder's Cardiovascular Disease History",
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: AppStyles.getTextFieldInputStyle(
                        hintText: 'Please Choose an Option'),
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
                "Bracelet Holder's Blood Pressure Condition History",
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: AppStyles.getTextFieldInputStyle(
                        hintText: 'Please Choose an Option'),
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
                'Emergency Contact',
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
                            return 'Please enter emergency contact Number';
                          }
                          if (!StringUtils.isPhoneNumber(value)) {
                            return 'Please enter a valid Phone Number';
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
                  buttonLabel: 'Register New Bracelet',
                  onClick: () async {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      await BlocProvider.of<ConnectBraceletCubit>(context)
                          .registerBracelet(
                              bracelet: BraceletEntity(
                                  id: widget.braceletId,
                                  holderFirstName: holderFirstName,
                                  holderLastName: holderLastName,
                                  holderEmergencyContact: emergencyContact,
                                  holderDateOfBirth: holderDateOfBirth,
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
