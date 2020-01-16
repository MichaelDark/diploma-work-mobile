import 'package:jaguar_serializer/jaguar_serializer.dart';

import 'home_item.dart';

part 'json_serializers.jser.dart';

final modelSerializerRepo = SerializerRepoImpl(serializers: [
  HomeItemJsonSerializer(),
]);

@GenSerializer()
class HomeItemJsonSerializer extends Serializer<HomeItem> with _$HomeItemJsonSerializer {}
