import 'package:flutter/material.dart';

class AppColors {
  AppColors.of(BuildContext context);

  Color get white => Color(0xFFFFFFFF);

  Color get black => Color(0xFF35323E);

  Color get blackOp50 => Color(0x8035323E);

  Color get textMainColor => Color(0xFF132238);

  Color get textColor => black;

  Color get errorColor => Color(0xFFEB5757);

  Color get green => Color(0xFF009933);

  Color get themeUiColor => green;

  Color get languageActive => Color(0xFF35323E);

  Color get languageInactive => Color(0xFFAAAAAA);
}
