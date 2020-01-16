import 'dart:async';

import 'package:chopper/chopper.dart';

import 'api_strings.dart';

part 'api_service.chopper.dart';

@ChopperApi()
abstract class ApiService extends ChopperService {
  static ApiService create([ChopperClient client]) => _$ApiService(client);

  @Get(path: urlExample, headers: defaultJsonHeaders)
  Future<Response<String>> getExampleString(
    @Header('Authorization') String token,
  );
}
