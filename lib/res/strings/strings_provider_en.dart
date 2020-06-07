part of '../strings.dart';

class EnStrings extends StringsProvider {
  EnStrings._();

  @override
  SupportedLocale get locale => SupportedLocale.english;

  @override
  String get languageName => 'English';

  @override
  String get languageShrug => 'ENG';

  @override
  String get appName => 'Graduation Work';

  @override
  String get textNoInternet => 'Нет интернета';

  @override
  String get error => "Ошибка";

  @override
  String get tryAgainWithExclamation => "Попробовать еще!";

  @override
  String get register => 'Зарегистрироваться!';

  @override
  String get email => 'Электронная почта';

  @override
  String get name => 'Имя';

  @override
  String get password => 'Пароль';

  @override
  String get registration => 'Регистрация';

  @override
  String get registerNewAccount => 'Зарегистрируйте новый аккаунт!';

  @override
  String get alreadyHaveAccount => 'Уже есть аккаунт';

  @override
  String get iForgotPassword => 'Я забыл пароль';

  @override
  String get logInWithExistingAccount => 'Войти с помощью существующего аккаунта';

  @override
  String get signIn => 'Вход';

  @override
  String get logout => 'Выйти';

  @override
  String get fieldIsRequired => 'Поле обязательно для ввода';

  @override
  String get invalidEmail => 'Неверный формат электронной почты';

  @override
  String get passwordShouldContain => 'Пароль должен быть минимум из 8 символов';

  @override
  String get receiveNewPassword => 'Получить пароль';

  @override
  String get receiveYourNewPasswordByEmail => 'Получите ваш новый пароль по указанному адресу электронной почты';

  @override
  String get passwordRestore => 'Восстановление пароля';

  @override
  String get back => 'Назад';

  @override
  String get takePhoto => 'Сделать снимок!';

  @override
  String get tryAgain => 'Попробовать снова';

  String get settings => 'Настройки';
}
