import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ixir_app/presentation/bloc/email_auth/email_auth_cubit.dart';
import 'package:ixir_app/presentation/navigation/route_paths.dart';
import 'package:ixir_app/presentation/screens/sign_in/sign_in_by_email_widget.dart';
import 'package:ixir_app/presentation/screens/sign_in/sign_in_by_phone_widget.dart';
import 'package:ixir_app/presentation/utils/string_utils.dart';
import 'package:ixir_app/presentation/widgets/buttons/custom_button_widget.dart';
import 'package:ixir_app/presentation/widgets/panel_over_scaffold.dart';
import 'package:ixir_app/presentation/widgets/progress_widget.dart';
import 'package:ixir_app/presentation/widgets/theme/app_colors.dart';
import 'package:ixir_app/presentation/widgets/theme/app_dimensions.dart';
import 'package:ixir_app/presentation/widgets/theme/app_styles.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

import '../../../app_const.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PanelOverScaffold(
        overflows: false,
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
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 30,
          title: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: AppColors.greyColor),
            tabs: [
              Tab(
                child: Text(
                  'Sign in with Email',
                  style: textTheme.bodyText1,
                ),
              ),
              Tab(
                child: Text(
                  'Sign in with Phone',
                  style: textTheme.bodyText1,
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: TabBarView(
            children: [
              SignInByEmailWidget(),
              SignInByPhoneWidget(),
            ],
          ),
        ),
      ),
    );
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
            'Welcome back!',
            style: AppStyles.header1WhiteText,
          ),
          const SizedBox(height: 26),
          Text(
            'Once you login in, you will be tuned with all the graphs and data to make sure your senior is safe and healthy.',
            style: AppStyles.regularWhiteText,
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
