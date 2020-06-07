class SupportedLocale {
  static const english = SupportedLocale._('en', 'GB');
  static const ukrainian = SupportedLocale._('uk', 'UA');

  static const defaultLocale = english;
  static const supportedLocales = [
    ukrainian,
    english,
  ];

  final String languageCode;
  final String countryCode;

  const SupportedLocale._(this.languageCode, this.countryCode);

  static SupportedLocale withLanguageCode(String code) => supportedLocales.firstWhere(
        (language) => language.languageCode == code,
        orElse: () => defaultLocale,
      );

  String get localeCode => toString();

  @override
  String toString() => countryCode == null || countryCode.isEmpty ? languageCode : '${languageCode}_$countryCode';
}
