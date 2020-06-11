import 'package:flutter/foundation.dart';

class PlantRequestNode {
  final int id;
  final String description;
  final String imageUrl;
  final List<String> otherImages;
  final num latitude;
  final num longitude;

  PlantRequestNode({
    @required this.id,
    @required this.description,
    @required this.imageUrl,
    this.otherImages,
    @required this.latitude,
    @required this.longitude,
  });
}
