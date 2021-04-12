import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'logo_header_app_bar.dart';
import 'theme/app_colors.dart';
import 'theme/app_dimensions.dart';

class PanelOverScaffold extends StatelessWidget {
  final Widget topWidget;
  final Widget bottomWidget;
  final Color backgroundColor;
  final Color foregroundColor;
  final SystemUiOverlayStyle brightness;
  final Color appBarTextColor;
  final bool overflows;

  const PanelOverScaffold({
    @required this.topWidget,
    @required this.bottomWidget,
    @required this.backgroundColor,
    this.foregroundColor = AppColors.whiteColor,
    this.appBarTextColor = AppColors.whiteColor,
    this.brightness = SystemUiOverlayStyle.light,
    this.overflows = true,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: brightness,
        child: SafeArea(
          bottom: false,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: AppDimensions.leftRightPagePadding,
                      child: LogoHeaderAppBar(
                        backgroundColor: backgroundColor,
                        textColor: appBarTextColor,
                      ),
                    ),
                    bottomWidget,
                  ],
                ),
              ),
              if (overflows)
                SliverToBoxAdapter(child: getTop())
              else
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: getTop(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTop() {
    return Container(
      padding: const EdgeInsets.only(top: 2),
      color: backgroundColor,
      child: Container(
        padding: const EdgeInsets.only(top: 24),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          color: foregroundColor,
        ),
        child: topWidget,
      ),
    );
  }
}
