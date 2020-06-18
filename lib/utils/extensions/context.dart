import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_work_mobile/models/plant_node.dart';
import 'package:graduation_work_mobile/res/strings.dart';
import 'package:graduation_work_mobile/ui/pages/auth/forgot_password/forgot_password_page.dart';
import 'package:graduation_work_mobile/ui/pages/auth/login/login_page.dart';
import 'package:graduation_work_mobile/ui/pages/auth/register/register_page.dart';
import 'package:graduation_work_mobile/ui/pages/home/home_page.dart';
import 'package:graduation_work_mobile/ui/pages/home/node_info/node_info_page.dart';
import 'package:graduation_work_mobile/ui/pages/home/plant_list/plant_list_page.dart';
import 'package:graduation_work_mobile/ui/pages/home/request_list/request_list_page.dart';
import 'package:graduation_work_mobile/ui/pages/home/settings/settings_page.dart';
import 'package:graduation_work_mobile/ui/pages/tools/language_page.dart';
import 'package:graduation_work_mobile/ui/pages/tools/permissions_page.dart';
import 'package:graduation_work_mobile/utils/extensions/permissions.dart';
import 'package:graduation_work_mobile/utils/storage.dart';

WidgetBuilder _loginPageBuilder = (BuildContext context) => RegisterPage();

enum PageTransitionType { Push, Replace, ClearStack }

extension ContextExtensions on BuildContext {
  DefaultStrings get strings => Strings.of(this);

  NavigatorState get navigator => Navigator.of(this);

  void _push(WidgetBuilder builder, {PageTransitionType type}) {
    switch (type) {
      case PageTransitionType.Push:
        navigator.push(CupertinoPageRoute(builder: builder));
        break;
      case PageTransitionType.ClearStack:
        navigator.pushAndRemoveUntil(CupertinoPageRoute(builder: builder), (_) => false);
        break;
      case PageTransitionType.Replace:
      default:
        navigator.pushReplacement(CupertinoPageRoute(builder: builder));
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

  void pushPlantList([LatLng location]) => _push((_) => PlantListPage(location), type: PageTransitionType.Push);

  void pushPlantNode(PlantNode node) => _push((_) => NodeInfoPage.fromNode(node), type: PageTransitionType.Push);

  void pushSpecimen(PlantNode node) => _push((_) => NodeInfoPage(node.id, false), type: PageTransitionType.Push);

  void pushPlantRequestList([LatLng loc]) => _push((_) => RequestListPage(loc), type: PageTransitionType.Push);

  void pushLogOut() => _push((_) => RegisterPage(), type: PageTransitionType.ClearStack);
}
