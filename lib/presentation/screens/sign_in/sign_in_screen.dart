import 'package:flutter/material.dart';

import '../../../common.dart';
import '../../widgets/panel_over_scaffold.dart';
import '../../widgets/theme/app_colors.dart';
import '../../widgets/theme/app_dimensions.dart';
import '../../widgets/theme/app_styles.dart';
import 'sign_in_by_email_widget.dart';
import 'sign_in_by_phone_widget.dart';

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
                  AppLocalizations.of(context).signInWithEmail,
                  style: textTheme.bodyText1,
                ),
              ),
              Tab(
                child: Text(
                  AppLocalizations.of(context).signInWithPhone,
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
            AppLocalizations.of(context).welcomeBack,
            style: AppStyles.header1WhiteText,
          ),
          const SizedBox(height: 26),
          Text(
            AppLocalizations.of(context)
                .onceYouLoginInYouWillBeTunedWithAllTheGraphsAndDataToMakeSureYourSeniorIsSafeAndHealthy,
            style: AppStyles.regularWhiteText,
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
