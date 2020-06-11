import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong/latlong.dart' as latlong;

import 'converter_utils.dart';

const _defaultArrivalAccuracyMeters = 10;
const _defaultAccuracy = LocationAccuracy.bestForNavigation;
//final _polylineInstance = GoogleMapPolyline(apiKey: GOOGLE_API_KEY);

Future<LatLng> getCurrentLocation({
  LocationAccuracy accuracy = _defaultAccuracy,
}) async {
  return positionToLatLng(
    await Geolocator().getCurrentPosition(
      desiredAccuracy: _defaultAccuracy,
    ),
  );
}

Stream<LatLng> getCurrentLocationStream({
  LocationAccuracy accuracy = _defaultAccuracy,
  int intervalMillis = 200,
}) {
  return Geolocator()
      .getPositionStream(LocationOptions(
        accuracy: _defaultAccuracy,
        timeInterval: intervalMillis,
      ))
      .map(positionToLatLng);
}

//Future<List<LatLng>> getPolylineCoordinates({
//  @required LatLng from,
//  @required LatLng to,
//}) {
//  return _polylineInstance.getCoordinatesWithLocation(
//    origin: from,
//    destination: to,
//    mode: RouteMode.walking,
//  );
//}

bool isArrived({
  @required LatLng userLocation,
  @required LatLng targetLocation,
}) {
  return userLocation != null &&
      targetLocation != null &&
      distanceBetweenMeters(userLocation, targetLocation) <= _defaultArrivalAccuracyMeters;
}

double distanceBetweenMeters(LatLng from, LatLng to) {
  return latlong.Distance()
      .as(
        latlong.LengthUnit.Meter,
        latlong.LatLng(from.latitude, from.longitude),
        latlong.LatLng(to.latitude, to.longitude),
      )
      .toDouble();
}
