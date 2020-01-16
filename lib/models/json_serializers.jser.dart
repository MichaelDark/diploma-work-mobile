// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_serializers.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$HomeItemJsonSerializer implements Serializer<HomeItem> {
  @override
  Map<String, dynamic> toMap(HomeItem model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'title', model.title);
    setMapValue(ret, 'description', model.description);
    setMapValue(ret, 'imageUrl', model.imageUrl);
    return ret;
  }

  @override
  HomeItem fromMap(Map map) {
    if (map == null) return null;
    final obj = HomeItem(
        map['id'] as int ?? getJserDefault('id'),
        map['title'] as String ?? getJserDefault('title'),
        map['description'] as String ?? getJserDefault('description'),
        map['imageUrl'] as String ?? getJserDefault('imageUrl'));
    return obj;
  }
}
