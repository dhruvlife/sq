import 'package:flutter/material.dart';
import 'package:sq/utils/constants/sizes.dart';
import '../../constants/colors.dart';

class TAppBarTheme{
  TAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: TColors.black, size: TSizes.iconMd),
    actionsIconTheme: IconThemeData(color: TColors.black, size: TSizes.iconMd),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: TColors.black),
  );
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Color.fromARGB(255, 220, 220, 220), size: TSizes.iconMd),
    actionsIconTheme: IconThemeData(color: TColors.white, size: TSizes.iconMd),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: TColors.white),
  );
}