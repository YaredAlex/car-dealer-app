import 'package:car_dealer/core/colors/colors.dart';
import 'package:car_dealer/core/sizes.dart';
import 'package:flutter/material.dart';

class CButtonTheme {
  static ElevatedButtonThemeData lightElevatedButton = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: CColors.primary,
    foregroundColor: Colors.white,
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CSizes.mdRadius)),
  ));

  static ElevatedButtonThemeData darkElevatedButton = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: CColors.primary,
    foregroundColor: Colors.white,
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CSizes.mdRadius)),
  ));
  static OutlinedButtonThemeData lightOutlinedButton = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.black87,
      side: const BorderSide(color: CColors.primary),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CSizes.smRadius),
      ),
      padding: const EdgeInsets.all(4),
    ),
  );

  static OutlinedButtonThemeData darkOutlinedButton = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      side: const BorderSide(color: CColors.primary),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CSizes.smRadius),
      ),
      padding: const EdgeInsets.all(4),
    ),
  );
}
