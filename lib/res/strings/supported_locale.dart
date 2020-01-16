class SupportedLocale {
  static const russian = SupportedLocale._('ru', 'RU');
  static const english = SupportedLocale._('en', 'GB');
  static const ukrainian = SupportedLocale._('uk', 'UA');

  static const defaultLocale = russian;
  static const supportedLocales = [
    russian,
    ukrainian,
    english,
  ];

  final String languageCode;
  final String countryCode;

  const SupportedLocale._(this.languageCode, this.countryCode);

  static SupportedLocale withLanguageCode(String code) => supportedLocales.firstWhere(
        (language) => language.languageCode == code,
        orElse: () => russian,
      );

  String get localeCode => toString();

  @override
  String toString() => countryCode == null || countryCode.isEmpty ? languageCode : '${languageCode}_$countryCode';
}
