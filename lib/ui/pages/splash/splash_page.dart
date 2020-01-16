import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dark_arch/res/app_assets.dart';
import 'package:flutter_dark_arch/ui/pages/home/home_page.dart';
import 'package:flutter_dark_arch/ui/pages/register/register_page.dart';
import 'package:flutter_dark_arch/utils/extensions/permissions.dart';
import 'package:flutter_dark_arch/utils/storage.dart';
import 'package:permission_handler/permission_handler.dart';

const _splashDuration = Duration(seconds: 1);

class SplashPage extends StatefulWidget {
  @override
  createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static const List<PermissionGroup> _neededPermissions = [
//    PermissionGroup.photos,
//    PermissionGroup.mediaLibrary,
    PermissionGroup.camera,
    PermissionGroup.storage,
    PermissionGroup.speech,
    PermissionGroup.location,
    PermissionGroup.microphone,
  ];

  Timer _timer;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  void _initializeApp() async {
    final storage = Storage();

    await storage.initializeLanguage();
    await storage.initializePath();

    _checkPermissions(_neededPermissions);
  }

  void _checkPermissions(List<PermissionGroup> permissions, {int deepLevel = 0}) async {
    final initialPermissionsResult = await PermissionHandler().requestPermissions(permissions);
    final isNotGranted = hasNotGrantedPermissions(initialPermissionsResult);

    if (deepLevel >= 3) {
      exit(0);
    } else if (isNotGranted) {
      _checkPermissions(permissions, deepLevel: ++deepLevel);
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer(
      _splashDuration,
      () async {
        if (mounted) {
          final String userEmail = await Storage().getUserEmail();
          if (userEmail == null || userEmail.trim().isEmpty) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => RegisterPage()),
            );
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => HomePage()),
            );
          }
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: Image.asset(
                AppAssets.icLogo,
                width: 270,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(36),
              child: Container(
                height: 64,
                width: 64,
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
