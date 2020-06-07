import 'dart:async';

import 'package:graduation_work_mobile/res/strings/supported_locale.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Storage._internal();

  static final Storage _instance = Storage._internal();

  factory Storage() => _instance;

  static const KEY_LANGUAGE_CODE = 'KEY_LANGUAGE_CODE';

  static const KEY_QUESTS_RU_JSON = 'KEY_QUESTS_RU_JSON';
  static const KEY_QUESTS_UK_JSON = 'KEY_QUESTS_UK_JSON';
  static const KEY_QUEST_START_TIMESTAMP_MILLIS_JSON = 'KEY_QUEST_START_TIMESTAMP_MILLIS_JSON';
  static const KEY_CURRENT_QUEST_JSON = 'KEY_CURRENT_QUEST_JSON';
  static const KEY_CURRENT_TASK_POSITION = 'KEY_CURRENT_TASK_POSITION';

  static const KEY_USER_EMAIL = 'KEY_USER_EMAIL';
  static const KEY_IS_MODERATOR = 'KEY_IS_MODERATOR';

  static const _IMAGES_DIRECTORY_NAME = 'images';

  ///
  /// General
  ///

  Future<T> _doOnPrefs<T>(FutureOr<T> Function(SharedPreferences) function) async {
    return function(await SharedPreferences.getInstance());
  }

  Future<void> clearStorage() => _doOnPrefs((prefs) => prefs.clear());

  ///
  /// Language
  ///

  // ignore: close_sinks
  final _languageCodeSubject = BehaviorSubject<String>.seeded(SupportedLocale.defaultLocale.languageCode);

  Stream<String> get languageCodeStream => _languageCodeSubject.stream;

  String get languageCode => _languageCodeSubject.value;

  Future<void> initializeLanguage() async {
    String savedLanguageCode = await _getLanguageCode();
    if (savedLanguageCode == null) {
      await _setLanguageCode(SupportedLocale.defaultLocale.languageCode);
    } else {
      _languageCodeSubject.add(savedLanguageCode);
    }
  }

  Future<void> setLanguageCode(String languageCode) async {
    await _setLanguageCode(languageCode);
    _languageCodeSubject.add(languageCode);
  }

  Future<void> _setLanguageCode(String code) => _doOnPrefs((prefs) => prefs.setString(KEY_LANGUAGE_CODE, code));

  Future<String> _getLanguageCode() => _doOnPrefs((prefs) => prefs.getString(KEY_LANGUAGE_CODE));

  ///
  /// Paths
  ///

  String _cacheDirectoryPath;

  String get cacheDirectoryPath => _cacheDirectoryPath;

  String get imagesDirectoryPath => path.join(_cacheDirectoryPath, _IMAGES_DIRECTORY_NAME);

  Future<void> initializePath() async {
    final appDirectory = await getApplicationSupportDirectory();
    _cacheDirectoryPath = appDirectory.path;
  }

  ///
  /// User Management
  ///

  Future<void> setUserEmail(String email) => _doOnPrefs((prefs) => prefs.setString(KEY_USER_EMAIL, email));

  Future<String> getUserEmail() => _doOnPrefs((prefs) => prefs.getString(KEY_USER_EMAIL));

  final _isModeratorSubject = BehaviorSubject<bool>.seeded(false);

  bool get isModerator => _isModeratorSubject.value;

  Future<void> setIsModerator(bool value) => _doOnPrefs((prefs) {
    _isModeratorSubject.add(value);
    return prefs.setBool(KEY_IS_MODERATOR, value);
  });

  Future<bool> getIsModerator() => _doOnPrefs((prefs) => prefs.getBool(KEY_IS_MODERATOR));

//  static const USER_CREDENTIALS_CODE = 'USER_CREDENTIALS_CODE';
//  static const TOKEN = 'TOKEN';
//  Future<void> setUserCredentials(UserCredentials credentials) async {
//    prefs = await getPrefs();
//    prefs.setString(USER_CREDENTIALS_EMAIL, credentials.email);
//    prefs.setString(USER_CREDENTIALS_CODE, credentials.activationCode);
//  }
//
//  Future<UserCredentials> getUserCredentials() async {
//    prefs = await getPrefs();
//    if (prefs.getString(USER_CREDENTIALS_EMAIL) == null) {
//      return null;
//    } else {
//      return UserCredentials(
//        email: prefs.getString(USER_CREDENTIALS_EMAIL),
//        activationCode: prefs.getString(USER_CREDENTIALS_CODE),
//      );
//    }
//  }
//
//
//  Future<bool> isFirstStart() async {
//    prefs = await getPrefs();
//    bool isFirst = prefs.get("IS_FIRST_START") ?? true;
//    return isFirst;
//  }
//
//  Future<void> setNotFirstStart() async {
//    prefs = await getPrefs();
//    prefs.setBool("IS_FIRST_START", false);
//  }
}
