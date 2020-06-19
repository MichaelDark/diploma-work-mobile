import 'package:flutter/foundation.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';

import 'user_info.dart';

class PlantRequestNode {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> otherImages;
  final num latitude;
  final num longitude;
  final UserInfo createUser;

  PlantRequestNode({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    this.otherImages,
    @required this.latitude,
    @required this.longitude,
    @required this.createUser,
  });

  @Ignore()
  List<String> get imageUrls => [
        imageUrl,
        if (otherImages != null) ...otherImages,
      ].where((url) => url != null).toList();
}
