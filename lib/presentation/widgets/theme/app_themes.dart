import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppThemes {
  static ThemeData getMainTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
      backgroundColor: AppColors.whiteColor,
      scaffoldBackgroundColor: AppColors.whiteColor,
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
          iconTheme: Theme.of(context).iconTheme,
          color: AppColors.whiteColor,
          elevation: 0,
          textTheme: Theme.of(context).textTheme),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Colors.purple,
        ),
      ),
    );
  }
}
