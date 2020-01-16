// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$ApiService extends ApiService {
  _$ApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = ApiService;

  Future<Response<String>> getExampleString(String token) {
    final $url = 'users';
    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Accept-Language': 'en'
    };
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<String, String>($request);
  }
}
