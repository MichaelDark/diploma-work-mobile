import 'package:jaguar_serializer/jaguar_serializer.dart';

import 'plant_node.dart';
import 'plant_request.dart';
import 'plant_request_node.dart';
import 'user_info.dart';

part 'json_serializers.jser.dart';

final modelSerializerRepo = SerializerRepoImpl(serializers: [
  PlantNodeJsonSerializer(),
  PlantRequestNodeJsonSerializer(),
  UserInfoJsonSerializer(),
  PlantRequestJsonSerializer(),
]);

@GenSerializer()
class PlantNodeJsonSerializer extends Serializer<PlantNode> with _$PlantNodeJsonSerializer {}

@GenSerializer()
class PlantRequestNodeJsonSerializer extends Serializer<PlantRequestNode> with _$PlantRequestNodeJsonSerializer {}

@GenSerializer()
class UserInfoJsonSerializer extends Serializer<UserInfo> with _$UserInfoJsonSerializer {}

@GenSerializer()
class PlantRequestJsonSerializer extends Serializer<PlantRequest> with _$PlantRequestJsonSerializer {}
