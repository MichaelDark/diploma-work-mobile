import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_work_mobile/res/app_colors.dart';
import 'package:graduation_work_mobile/utils/extensions/context.dart';
import 'package:graduation_work_mobile/utils/location_utils.dart';
import 'package:stream_transform/stream_transform.dart';

const _locationDebounceDuration = Duration(milliseconds: 300);
const _startZoom = 16.0;
const _tabPadding = 12.0;
const _tabIconSize = 36.0;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LatLng _lastUserLocation;

  GoogleMapController _controller;

  void _onUserLocationChanged(LatLng coordinates) {
    _lastUserLocation = coordinates;
  }

  void _onMapCreated(GoogleMapController receivedController) async {
    _controller = receivedController;
    getCurrentLocationStream().takeWhile((_) => mounted).take(1).listen(_moveCameraTo);
    getCurrentLocationStream().takeWhile((_) => mounted).debounce(_locationDebounceDuration).listen(
      (LatLng userLocation) {
        _lastUserLocation = userLocation;
        _onUserLocationChanged(_lastUserLocation);
      },
    );
  }

  void _moveCameraTo(LatLng location, {double zoom = _startZoom}) {
    if (location != null) {
      _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: location,
        zoom: zoom,
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: _buildMap(),
              ),
              _buildBottomButtons(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      zoomGesturesEnabled: true,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      indoorViewEnabled: false,
      tiltGesturesEnabled: false,
      trafficEnabled: false,
      rotateGesturesEnabled: true,
      padding: EdgeInsets.only(top: 42),
      initialCameraPosition: CameraPosition(
        target: _lastUserLocation ?? LatLng(0, 0),
        zoom: _startZoom,
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildImageTab(AssetImage('res/ic_plants.png'), () {
            context.pushPlantList(_lastUserLocation);
          }),
          _buildIconTab(Icons.add_circle, () {
            //TODO
          }),
          _buildIconTab(Icons.featured_play_list, () {
            context.pushPlantRequestList();
          }),
          _buildIconTab(Icons.settings, () {
            context.pushSettings();
          }),
        ],
      ),
    );
  }

  Widget _buildIconTab(IconData iconData, VoidCallback onTap) {
    return IconButton(
      padding: EdgeInsets.all(_tabPadding),
      icon: Icon(iconData),
      color: AppColors.of(context).green,
      iconSize: _tabIconSize,
      onPressed: onTap,
    );
  }

  Widget _buildImageTab(ImageProvider imageProvider, VoidCallback onTap) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(_tabPadding),
        child: Image(
          image: imageProvider,
          height: _tabIconSize,
          width: _tabIconSize,
        ),
      ),
      onTap: onTap,
    );
  }
}
