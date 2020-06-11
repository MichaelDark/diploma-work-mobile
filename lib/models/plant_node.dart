import 'package:flutter/foundation.dart';

import 'user_info.dart';

class PlantNode {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> otherImages;
  final num latitude;
  final num longitude;
  final UserInfo createUser;
  final UserInfo approveUser;
  final List<PlantNode> childNodes;

  const PlantNode({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    this.otherImages,
    @required this.latitude,
    @required this.longitude,
    @required this.createUser,
    @required this.approveUser,
    this.childNodes,
  });

  bool get isArea => childNodes != null && childNodes.isNotEmpty;

  List<String> get imageUrls => [
        imageUrl,
        if (otherImages != null) ...otherImages,
      ].where((url) => url != null).toList();
}
