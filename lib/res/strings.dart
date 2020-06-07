import 'package:flutter/material.dart';
import 'package:graduation_work_mobile/utils/storage.dart';

import 'strings/supported_locale.dart';

part 'strings/strings_provider.dart';
part 'strings/strings_provider_en.dart';
part 'strings/strings_provider_uk.dart';

abstract class Strings {
  Strings._();

  static StringsProvider of(BuildContext context) {
    String savedLangCode = Storage().languageCode;
    String contextLangCode = getLanguageCodeFromContext(context);
    String languageCode = savedLangCode ?? contextLangCode ?? SupportedLocale.defaultLocale;
    return ofLanguageCode(languageCode);
  }

  static String getLanguageCodeFromContext(BuildContext context) {
    return Localizations.localeOf(context, nullOk: true)?.languageCode;
  }

  static StringsProvider ofLocale(SupportedLocale locale) => ofLanguageCode(locale.languageCode);

  static StringsProvider ofLanguageCode(String languageCode) {
    if (languageCode == SupportedLocale.ukrainian.languageCode) return UkStrings._();
    if (languageCode == SupportedLocale.english.languageCode) return EnStrings._();
    return EnStrings._();
  }
}
