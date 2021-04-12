import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ixir_app/presentation/navigation/route_paths.dart';
import 'package:ixir_app/presentation/widgets/buttons/custom_button_widget.dart';
import 'package:ixir_app/presentation/widgets/panel_over_scaffold.dart';
import 'package:ixir_app/presentation/widgets/progress_widget.dart';
import 'package:ixir_app/presentation/widgets/theme/app_colors.dart';
import 'package:ixir_app/presentation/widgets/theme/app_dimensions.dart';
import 'package:ixir_app/presentation/widgets/theme/app_styles.dart';
import 'package:ixir_app/presentation/bloc/connect_bracelet/connect_bracelet_cubit.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

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
                'Bracelet Serial Number',
                style: AppStyles.inputLabelTextStyle,
              ),
              const SizedBox(height: 9),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: AppStyles.getTextFieldInputStyle(
                    hintText: 'Enter your Bracelet Serial Number'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your Bracelet Serial Number';
                  } else if (value.length < 4) {
                    return 'Please enter a valid serial number';
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
                  buttonLabel: 'Submit',
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
                buttonLabel: "Can't find the serial number?",
                onClick: () {},
                buttonColorBt: Colors.transparent,
                labelColorBt: AppColors.blueColor,
                borderColorBt: AppColors.blueColor,
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
            'Connect to a bracelet',
            style: AppStyles.header1WhiteText,
          ),
          const SizedBox(height: 26),
          Text(
            'You will find a serial number printed on Ixir Health Monitoring Bracelet. To connect it with your account, please enter this serial number below.',
            style: AppStyles.regularWhiteText,
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
