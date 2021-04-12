import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final String labelBt;
  final void Function() onClickBt;
  final bool isEnableBt;
  final IconData iconBt;

  final Color buttonColor;
  final Color buttonDisabledColor;
  final Color labelColor;
  final Color labelDisabledColor;

  final Color borderColor;
  final Color borderDisabledColor;

  const BaseButton(
      {@required this.labelBt,
      @required this.buttonColor,
      @required this.buttonDisabledColor,
      @required this.labelColor,
      @required this.labelDisabledColor,
      @required this.borderColor,
      @required this.borderDisabledColor,
      @required this.onClickBt,
      this.isEnableBt,
      this.iconBt,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnableBt ? onClickBt : null,
      style: ElevatedButton.styleFrom(
        primary: isEnableBt ? buttonColor : buttonDisabledColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(
            color: isEnableBt ? borderColor : borderDisabledColor,
          ),
        ),
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
        alignment: Alignment.center,
      ),
      child: SizedBox(
        height: 55,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                labelBt ?? '',
                style: TextStyle(
                    color: isEnableBt ? labelColor : labelDisabledColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
