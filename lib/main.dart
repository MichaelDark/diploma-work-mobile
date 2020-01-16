import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'application.dart';

const GOOGLE_API_KEY = ""; /*TODO*/

List<CameraDescription> cameras;

void main() async {
  cameras = await availableCameras();
//  debugPaintSizeEnabled=true;
  _setupLogging();
  _setupDatabase();
  runApp(App());
}

Future<void> _setupDatabase() async {
//  SqfliteAdapter adapter = SqfliteAdapter(BuildConfig.dbName, version: BuildConfig.dbVersion);
//  await adapter.connect();
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
