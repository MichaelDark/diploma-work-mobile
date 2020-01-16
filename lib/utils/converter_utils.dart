import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

double degreesToRad(double degrees) => degrees * pi / 180;

LatLng positionToLatLng(Position position) => LatLng(position?.latitude ?? 0, position?.longitude ?? 0);

Future<Uint8List> getBytesFromAsset(String path, double height) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(
    data.buffer.asUint8List(),
    targetHeight: height.toInt(),
  );
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
}
