import 'package:car_dealer/core/colors/colors.dart';
import 'package:car_dealer/core/theme/appbar_theme.dart';
import 'package:car_dealer/core/theme/button_theme.dart';
import 'package:car_dealer/core/theme/inputDecoration.dart';
import 'package:car_dealer/core/theme/switchlist_theme.dart';
import 'package:car_dealer/core/theme/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: CColors.bgGray,
      textTheme: CTextTheme.lightText,
      brightness: Brightness.light,
      elevatedButtonTheme: CButtonTheme.lightElevatedButton,
      primaryColor: CColors.primary,
      inputDecorationTheme: CInputDecoration.lightDecoration,
      outlinedButtonTheme: CButtonTheme.lightOutlinedButton,
      switchTheme: CSwitchListTheme.lightSwitchList,
      appBarTheme: CAppBarTheme.lightAppbarTheme);

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: CColors.backgroundDark,
      textTheme: CTextTheme.darkText,
      brightness: Brightness.dark,
      elevatedButtonTheme: CButtonTheme.darkElevatedButton,
      primaryColor: CColors.primary,
      inputDecorationTheme: CInputDecoration.darkDecoration,
      switchTheme: CSwitchListTheme.darkSwitchList,
      outlinedButtonTheme: CButtonTheme.darkOutlinedButton,
      appBarTheme: CAppBarTheme.darkAppbarTheme);
}
