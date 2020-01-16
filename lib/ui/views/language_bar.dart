import 'package:flutter/material.dart';
import 'package:graduation_work_mobile/res/app_colors.dart';
import 'package:graduation_work_mobile/res/strings.dart';
import 'package:graduation_work_mobile/res/strings/supported_locale.dart';
import 'package:graduation_work_mobile/utils/functional_interfaces.dart';
import 'package:graduation_work_mobile/utils/storage.dart';

class LanguageBar extends StatelessWidget {
  final SingleCallback<SupportedLocale> onLanguageChanged;

  const LanguageBar({this.onLanguageChanged});

  void _onNewLanguageSelected(BuildContext context, SupportedLocale locale) async {
    if (Strings.of(context).locale != locale) {
      await Storage().setLanguageCode(locale.languageCode);
      if (onLanguageChanged != null) {
        onLanguageChanged(locale);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _buildLanguageButton(SupportedLocale.russian),
          _buildLanguageButton(SupportedLocale.ukrainian),
        ],
      ),
    );
  }

  Widget _buildLanguageButton(SupportedLocale locale) {
    return Builder(
      builder: (BuildContext context) {
        return GestureDetector(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Text(
              Strings.ofLanguageCode(locale.languageCode).languageShrug,
              style: TextStyle(
                color: Strings.of(context).locale == locale
                    ? AppColors.of(context).languageActive
                    : AppColors.of(context).languageInactive,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          onTap: () => _onNewLanguageSelected(context, locale),
        );
      },
    );
  }
}
