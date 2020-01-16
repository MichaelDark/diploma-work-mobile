part of '../strings.dart';

class UkStrings implements StringsProvider {
  UkStrings._();

  @override
  SupportedLocale get locale => SupportedLocale.ukrainian;

  @override
  String get languageShrug => 'УКР';

  @override
  String get appName => 'Харківські Квести';

  @override
  String get textNoInternet => 'Немає інтернету';

  @override
  String get error => "Помилка";

  @override
  String get tryAgainWithExclamation => "Спробувати ще!";

  @override
  String get register => 'Зареєструватися!';

  @override
  String get email => 'Електронна пошта';

  @override
  String get name => 'Iм\'я';

  @override
  String get password => 'Пароль';

  @override
  String get registration => 'Реєстрацiя';

  @override
  String get registerNewAccount => 'Зареєструйте новий акаунт!';

  @override
  String get alreadyHaveAccount => 'Акаунт вже iснує';

  @override
  String get iForgotPassword => 'Я забув пароль';

  @override
  String get logInWithExistingAccount => 'Увiйти за допомогою iснуючого акаунту';

  @override
  String get signIn => 'Вхiд';

  @override
  String get logout => 'Вийти';

  @override
  String get fieldIsRequired => 'Поле обов\'язкове для вводу';

  @override
  String get invalidEmail => 'Невiрний формат електронної пошти';

  @override
  String get passwordShouldContain => 'Пароль повинен складатися з 8 символiв або бiльше';

  @override
  String get receiveNewPassword => 'Отримати пароль';

  @override
  String get receiveYourNewPasswordByEmail => 'Отримайте ваш новий пароль за вказаною адресою електронної пошти';

  @override
  String get passwordRestore => 'Відновлення пароля';

  @override
  String get back => 'Назад';

  @override
  String get takePhoto => 'Зробити фото!';

  @override
  String get tryAgain => 'Спробувати ще';
}
