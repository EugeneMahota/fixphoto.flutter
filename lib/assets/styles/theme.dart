import 'package:flutter/material.dart';

class AppTheme {
  get defaultTheme => ThemeData(
        primarySwatch: Colors.blue,
      );
}

class AppColors {
  Color get white => Color(0xFFFFFFFF);
  Color get pink => Color(0xFFC193DC);
  Color get greySubtext => Color(0xFF707070);
  Color get backgroundRedError => Color(0xFFd32f2f);

  Color get disableTextColor => Color(0xFF888888);
  Color get disableBackgroundColor => Color(0xFFCCCCCC);
}
