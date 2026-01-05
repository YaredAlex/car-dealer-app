import 'package:car_dealer/core/colors/colors.dart';
import 'package:flutter/material.dart';

class CAppBarTheme {
  CAppBarTheme._();

  static const AppBarTheme lightAppbarTheme = AppBarTheme(
    backgroundColor: CColors.bgGray,
    foregroundColor: Colors.black,
    scrolledUnderElevation: 0,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
  );
  static const AppBarTheme darkAppbarTheme = AppBarTheme(
    backgroundColor: CColors.backgroundDark,
    foregroundColor: Colors.white,
    scrolledUnderElevation: 0,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
  );
}
