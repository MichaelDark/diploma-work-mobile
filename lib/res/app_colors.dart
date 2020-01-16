import 'package:flutter/material.dart';

class AppColors {
  AppColors.of(BuildContext context);

  Color get white => Color(0xFFFFFFFF);

  Color get black => Color(0xFF35323E);

  Color get blackOp50 => Color(0x8035323E);

  Color get green => Color(0xFF67BB33);

  Color get textMainColor => Color(0xFF132238);

  Color get textColor => black;

  Color get questDefaultColor => Color(0xFF57F2FF);

  Color get hintsColor => Color(0xFFFC7753);

  Color get errorColor => Color(0xFFEB5757);

  Color get themeUiColor => Color(0xFF00BDFF);

  Color get mapPageBottomSheetBackground => white;

  Color get languageActive => Color(0xFF35323E);

  Color get languageInactive => Color(0xFFAAAAAA);
}
