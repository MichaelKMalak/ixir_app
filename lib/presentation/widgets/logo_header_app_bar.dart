import 'package:flutter/material.dart';
import 'package:ixir_app/presentation/widgets/theme/app_dimensions.dart';

class LogoHeaderAppBar extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final bool forceHideBackButton;

  const LogoHeaderAppBar({
    Key key,
    @required this.backgroundColor,
    @required this.textColor,
    this.forceHideBackButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (Navigator.canPop(context) && !forceHideBackButton)
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back, color: textColor),
            )
          else
            Container(),
          Text(
            'ixir HMB',
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
