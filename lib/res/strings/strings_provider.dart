part of '../strings.dart';

abstract class StringsProvider {
  SupportedLocale get locale;

  String get languageShrug;

  String get appName;

  String get textNoInternet;

  String get error;

  String get tryAgainWithExclamation;

  String get register;

  String get email;

  String get name;

  String get password;

  String get registration;

  String get registerNewAccount;

  String get alreadyHaveAccount;

  String get iForgotPassword;

  String get logInWithExistingAccount;

  String get signIn;

  String get logout;

  String get invalidEmail;

  String get fieldIsRequired;

  String get passwordShouldContain;

  String get passwordRestore;

  String get receiveYourNewPasswordByEmail;

  String get receiveNewPassword;

  String get back;

  String get takePhoto;

  String get tryAgain;

  String get settings => 'Настройки';

  String get language;
}
