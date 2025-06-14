
import 'package:event_admin/core/config/config.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",
    scaffoldBackgroundColor: Colors.white,
    shadowColor: Colors.transparent,
    hoverColor: Colors.black12.withAlpha(5),
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(fontSize: 18, color: Config.whiteClr),
      surfaceTintColor: Colors.transparent,
      backgroundColor: Config.violetClr,
      elevation: 0,
      foregroundColor: Colors.white,
    ),
  );
}
