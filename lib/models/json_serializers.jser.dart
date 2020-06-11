// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_serializers.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$PlantNodeJsonSerializer implements Serializer<PlantNode> {
  Serializer<PlantNode> __plantNodeJsonSerializer;

  Serializer<PlantNode> get _plantNodeJsonSerializer => __plantNodeJsonSerializer ??= PlantNodeJsonSerializer();

  @override
  Map<String, dynamic> toMap(PlantNode model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'isArea', model.isArea);
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'title', model.title);
    setMapValue(ret, 'description', model.description);
    setMapValue(ret, 'imageUrl', model.imageUrl);
    setMapValue(ret, 'otherImages', codeIterable(model.otherImages, (val) => val as String));
    setMapValue(ret, 'latitude', model.latitude);
    setMapValue(ret, 'longitude', model.longitude);
    setMapValue(
        ret, 'childNodes', codeIterable(model.childNodes, (val) => _plantNodeJsonSerializer.toMap(val as PlantNode)));
    return ret;
  }

  @override
  PlantNode fromMap(Map map) {
    if (map == null) return null;
    final obj = PlantNode(
        id: map['id'] as int ?? getJserDefault('id'),
        title: map['title'] as String ?? getJserDefault('title'),
        description: map['description'] as String ?? getJserDefault('description'),
        imageUrl: map['imageUrl'] as String ?? getJserDefault('imageUrl'),
        otherImages: codeIterable<String>(map['otherImages'] as Iterable, (val) => val as String) ??
            getJserDefault('otherImages'),
        latitude: map['latitude'] as num ?? getJserDefault('latitude'),
        longitude: map['longitude'] as num ?? getJserDefault('longitude'),
        childNodes: codeIterable<PlantNode>(
                map['childNodes'] as Iterable, (val) => _plantNodeJsonSerializer.fromMap(val as Map)) ??
            getJserDefault('childNodes'));
    return obj;
  }
}

abstract class _$PlantRequestNodeJsonSerializer implements Serializer<PlantRequestNode> {
  @override
  Map<String, dynamic> toMap(PlantRequestNode model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'description', model.description);
    setMapValue(ret, 'imageUrl', model.imageUrl);
    setMapValue(ret, 'otherImages', codeIterable(model.otherImages, (val) => val as String));
    setMapValue(ret, 'latitude', model.latitude);
    setMapValue(ret, 'longitude', model.longitude);
    return ret;
  }

  @override
  PlantRequestNode fromMap(Map map) {
    if (map == null) return null;
    final obj = PlantRequestNode(
        id: map['id'] as int ?? getJserDefault('id'),
        description: map['description'] as String ?? getJserDefault('description'),
        imageUrl: map['imageUrl'] as String ?? getJserDefault('imageUrl'),
        otherImages: codeIterable<String>(map['otherImages'] as Iterable, (val) => val as String) ??
            getJserDefault('otherImages'),
        latitude: map['latitude'] as num ?? getJserDefault('latitude'),
        longitude: map['longitude'] as num ?? getJserDefault('longitude'));
    return obj;
  }
}

abstract class _$UserInfoJsonSerializer implements Serializer<UserInfo> {
  @override
  Map<String, dynamic> toMap(UserInfo model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'isModerator', model.isModerator);
    setMapValue(ret, 'maskedEmail', model.maskedEmail);
    return ret;
  }

  @override
  UserInfo fromMap(Map map) {
    if (map == null) return null;
    final obj = UserInfo(
        id: map['id'] as int ?? getJserDefault('id'),
        isModerator: map['isModerator'] as bool ?? getJserDefault('isModerator'),
        maskedEmail: map['maskedEmail'] as String ?? getJserDefault('maskedEmail'));
    return obj;
  }
}

abstract class _$PlantRequestJsonSerializer implements Serializer<PlantRequest> {
  @override
  Map<String, dynamic> toMap(PlantRequest model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'title', model.title);
    setMapValue(ret, 'description', model.description);
    setMapValue(ret, 'latitude', model.latitude);
    setMapValue(ret, 'longitude', model.longitude);
    return ret;
  }

  @override
  PlantRequest fromMap(Map map) {
    if (map == null) return null;
    final obj = PlantRequest(
        title: map['title'] as String ?? getJserDefault('title'),
        description: map['description'] as String ?? getJserDefault('description'),
        latitude: map['latitude'] as num ?? getJserDefault('latitude'),
        longitude: map['longitude'] as num ?? getJserDefault('longitude'));
    return obj;
  }
}
