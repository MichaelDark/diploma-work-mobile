import 'package:flutter/material.dart';
import 'package:graduation_work_mobile/utils/storage.dart';

import 'strings/supported_locale.dart';

part 'strings/strings_provider_en.dart';
part 'strings/strings_provider_uk.dart';

abstract class Strings {
  Strings._();

  static DefaultStrings of(BuildContext context) {
    String savedLangCode = Storage().languageCode;
    String contextLangCode = getLanguageCodeFromContext(context);
    String languageCode = savedLangCode ?? contextLangCode ?? SupportedLocale.defaultLocale;
    return ofLanguageCode(languageCode);
  }

  static String getLanguageCodeFromContext(BuildContext context) {
    return Localizations.localeOf(context, nullOk: true)?.languageCode;
  }

  static DefaultStrings ofLocale(SupportedLocale locale) => ofLanguageCode(locale.languageCode);

  static DefaultStrings ofLanguageCode(String languageCode) {
    if (languageCode == SupportedLocale.ukrainian.languageCode) return UkStrings();
    if (languageCode == SupportedLocale.english.languageCode) return DefaultStrings();
    return DefaultStrings();
  }
}
