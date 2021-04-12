import 'package:flutter/material.dart';
import 'theme/app_colors.dart';

class ProgressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.blueColor),
      ),
    );
  }
}
