import 'package:flutter/material.dart';
import 'package:graduation_work_mobile/res/strings.dart';
import 'package:graduation_work_mobile/ui/pages/auth/forgot_password/forgot_password_page.dart';
import 'package:graduation_work_mobile/ui/pages/auth/login/login_page.dart';
import 'package:graduation_work_mobile/ui/pages/auth/register/register_page.dart';
import 'package:graduation_work_mobile/ui/pages/home/home_page.dart';
import 'package:graduation_work_mobile/ui/pages/home/settings/settings_page.dart';
import 'package:graduation_work_mobile/ui/pages/tools/language_page.dart';
import 'package:graduation_work_mobile/ui/pages/tools/permissions_page.dart';
import 'package:graduation_work_mobile/utils/extensions/permissions.dart';
import 'package:graduation_work_mobile/utils/storage.dart';

WidgetBuilder _loginPageBuilder = (BuildContext context) => RegisterPage();

enum PageTransitionType { Push, Replace, ClearStack }

extension ContextExtensions on BuildContext {
  StringsProvider get strings => Strings.of(this);

  NavigatorState get navigator => Navigator.of(this);

  void _push(WidgetBuilder builder, {PageTransitionType type}) {
    switch (type) {
      case PageTransitionType.Push:
        navigator.push(MaterialPageRoute(builder: builder));
        break;
      case PageTransitionType.ClearStack:
        navigator.pushAndRemoveUntil(MaterialPageRoute(builder: builder), (_) => false);
        break;
      case PageTransitionType.Replace:
      default:
        navigator.pushReplacement(MaterialPageRoute(builder: builder));
        break;
    }
  }

  void pushPage(WidgetBuilder builder, {PageTransitionType type = PageTransitionType.Push}) async {
    if (Storage().languageCode == null) {
      pushLanguagePage(nextPageBuilder: builder, type: type);
    } else if (!(await checkAppPermissions())) {
      pushPermissionsPage(nextPageBuilder: builder, type: type);
    } else {
      _push(builder, type: type);
    }
  }

  void pushLanguagePage({WidgetBuilder nextPageBuilder, PageTransitionType type = PageTransitionType.Replace}) {
    _push((_) => LanguagePage(nextPageBuilder ?? _loginPageBuilder), type: type);
  }

  void pushPermissionsPage({WidgetBuilder nextPageBuilder, PageTransitionType type = PageTransitionType.Replace}) {
    _push((_) => PermissionsPage(nextPageBuilder ?? _loginPageBuilder), type: type);
  }

  void pushFirstPage({PageTransitionType type = PageTransitionType.ClearStack}) async {
    final String userEmail = await Storage().getUserEmail();
    if (userEmail == null || userEmail.trim().isEmpty) {
      pushPage((_) => RegisterPage(), type: type);
    } else {
      pushPage((_) => HomePage(), type: type);
    }
  }

  void pushLogin() => _push((_) => LoginPage(), type: PageTransitionType.Push);

  void pushForgotPassword() => _push((_) => ForgotPasswordPage(), type: PageTransitionType.Push);
  void pushSettings() => _push((_) => SettingsPage(), type: PageTransitionType.Push);

  void pushLogOut() => _push((_) => RegisterPage(), type: PageTransitionType.ClearStack);
}
