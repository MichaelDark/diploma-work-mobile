import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_work_mobile/models/plant_node.dart';

const _startZoom = 12.0;

class PlantMap extends StatefulWidget {
  final LatLng selectedPosition;
  final bool isMovable;
  final List<PlantNode> nodes;
  final VoidCallback onMapCreated;
  final ValueChanged<PlantNode> onMarkerTap;
  final bool showLocationButton;

  const PlantMap({
    Key key,
    @required this.selectedPosition,
    this.nodes,
    this.onMapCreated,
    this.onMarkerTap,
    this.showLocationButton = true,
    this.isMovable = true,
  }) : super(key: key);

  @override
  _PlantMapState createState() => _PlantMapState();
}

class _PlantMapState extends State<PlantMap> {
  bool _isNavigated = false;
  GoogleMapController _controller;
  List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    if (widget.selectedPosition != null && !_isNavigated) {
      _isNavigated = true;
      _moveCameraTo(widget.selectedPosition);
    }
    if (widget.nodes != null) {
      _updateMarkers(widget.nodes);
    }
  }

  @override
  void didUpdateWidget(PlantMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (mounted) {
      if (widget.selectedPosition != null && !_isNavigated) {
        _isNavigated = true;
        _moveCameraTo(widget.selectedPosition);
      }
      if (widget.nodes != null) {
        _updateMarkers(widget.nodes);
      }
    }
  }

  void _moveCameraTo(LatLng location, {double zoom = _startZoom}) {
    if (location != null) {
      _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: location,
        zoom: zoom,
      )));
    }
  }

  void _updateMarkers(List<PlantNode> nodes) async {
    _markers = await _getMarkersFromPlantNodes(widget.nodes);
    setState(() {});
  }

  Future<List<Marker>> _getMarkersFromPlantNodes(List<PlantNode> nodes) async {
    List<Marker> markers = [];
    for (PlantNode node in nodes) {
      markers.add(Marker(
        markerId: MarkerId("${node.id}${node.latitude}${node.longitude}"),
        position: LatLng(node.latitude, node.longitude),
        icon: node.isArea
            ? BitmapDescriptor.fromBytes(await getBytesFromAsset('res/ic_area.png', 64))
            : BitmapDescriptor.fromBytes(await getBytesFromAsset('res/ic_node.png', 64)),
        onTap: () => widget.onMarkerTap?.call(node),
      ));
    }
    return markers;
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png)).buffer.asUint8List();
  }

  void _onMapCreated(GoogleMapController receivedController) async {
    _controller = receivedController;
    widget.onMapCreated?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      markers: _markers.toSet() ?? Set(),
      zoomGesturesEnabled: widget.isMovable ?? true,
      myLocationEnabled: widget.showLocationButton ?? true,
      myLocationButtonEnabled: widget.showLocationButton ?? true,
      indoorViewEnabled: false,
      tiltGesturesEnabled: false,
      trafficEnabled: false,
      scrollGesturesEnabled: widget.isMovable ?? true,
      rotateGesturesEnabled: widget.isMovable ?? true,
      padding: EdgeInsets.only(top: 42),
      initialCameraPosition: CameraPosition(
        target: widget.selectedPosition ?? LatLng(56, 36.13),
        zoom: _startZoom,
      ),
    );
  }
}
