import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:graduation_work_mobile/utils/extensions/context.dart';
import 'package:graduation_work_mobile/utils/storage.dart';
import 'package:logging/logging.dart';

import '../../../main.dart';

const _splashDuration = Duration(seconds: 1);

class SplashPage extends StatefulWidget {
  @override
  createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
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

    cameras = await availableCameras();
    _setupLogging();
    _startTimer();
  }

  void _setupLogging() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    });
  }

  void _startTimer() {
    _timer = Timer(_splashDuration, () {
      if (mounted) context.pushFirstPage();
    });
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
//            Padding(
//              padding: EdgeInsets.all(16),
//              child: Image.asset(
//                AppAssets.icLogo,
//                width: 270,
//              ),
//            ),
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
