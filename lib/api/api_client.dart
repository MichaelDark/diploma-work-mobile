import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_work_mobile/api/model/forgot_password_request.dart';
import 'package:graduation_work_mobile/api/model/login_request.dart';
import 'package:graduation_work_mobile/api/model/request_error.dart';
import 'package:graduation_work_mobile/models/plant_node.dart';
import 'package:graduation_work_mobile/models/plant_request_node.dart';
import 'package:graduation_work_mobile/models/user_info.dart';
import 'package:graduation_work_mobile/utils/extensions/context.dart';
import 'package:graduation_work_mobile/utils/storage.dart';

import 'api_client_contract.dart';
import 'api_service.dart';
import 'api_strings.dart';
import 'model/register_request.dart';
import 'util/error_json_converter.dart';
import 'util/example_interceptor.dart';
import 'util/jaguar_json_converter.dart';
import 'util/mock_provider.dart';

class ApiClient implements ApiClientContract {
  final BuildContext context;

  ApiClient(this.context);

  static final ChopperClient chopper = ChopperClient(
    baseUrl: baseUrl,
    services: [
      ApiService.create(),
    ],
    converter: JaguarJsonConverter(),
    errorConverter: ErrorJsonConverter(),
    interceptors: [
      ExampleInterceptor(),
      HttpLoggingInterceptor(),
    ],
  );

  static final apiService = chopper.getService<ApiService>();

  Future<Response<String>> getExampleString(String token) {
    return _callRequest(apiService.getExampleString(token));
  }

  ///
  /// Data API
  ///

  //TODO add API
  Future<String> register(RegisterRequest request) async {
    await Future.delayed(Duration(seconds: 2));
    users[request.email] = UserInfo(
      id: users.values.map((userInfo) => userInfo.id).fold(1, max) + 1,
      maskedEmail: request.email.trim(),
      isModerator: false,
    );
    return request.email;
  }

  //TODO add API
  Future<String> login(LoginRequest request) async {
    if (request.password != defaultPassword) throw "Incorrect password";
    if (users.keys.where((email) => email.trim() == request.email.trim()).isEmpty) throw "Email do not exist";
    await Future.delayed(Duration(seconds: 2));
    final user = users[request.email];
    Storage().setIsModerator(user.isModerator);
    return request.email;
  }

  //TODO add API
  Future<String> forgotPassword(ForgotPasswordRequest request) async {
    await Future.delayed(Duration(seconds: 2));
    return request.email;
  }

  //TODO add API
  Future<List<PlantNode>> getPlantNodes([LatLng location]) async {
    final mockLocation = location ?? defaultLocation;
    await Future.delayed(Duration(seconds: 2));
    return Future.value(getNodes(mockLocation));
  }

  //TODO add API
  Future<PlantNode> getPlantNode(int id, bool isArea) async {
    await Future.delayed(Duration(milliseconds: 500));
    var node = getNodes(defaultLocation).firstWhere(
      (node) {
        return node.id == id || node.childNodes?.firstWhere((node) => node.id == id, orElse: () => null) != null;
      },
      orElse: () => getNodes(defaultLocation).first,
    );
    if (node.id != id) {
      node = node.childNodes.firstWhere(
        (node) => node.id == id,
        orElse: () => getNodes(defaultLocation).first,
      );
    }
    if (!isArea) {
      node.childNodes?.clear();
    }
    return Future.value(node);
  }

  //TODO add API
  Future<List<PlantRequestNode>> getPlantRequestNodes([LatLng location]) async {
    final mockLocation = location ?? defaultLocation;
    await Future.delayed(Duration(seconds: 2));
    return Future.value(getRequestNodes(mockLocation));
  }

  ///
  /// General
  ///

  Future<Response<T>> _callRequest<T>(Future<Response<T>> apiCall) async {
    try {
      Response<T> res = await apiCall;
      return res;
    } on Response catch (errorResponse) {
      return Future.error(RequestError(
        errorResponse.statusCode,
        errorResponse.body,
        errorResponse,
      ));
    } catch (exception) {
      if (exception is SocketException) {
        return Future.error(RequestError(
          -1,
          context.strings.textNoInternet,
          exception,
        ));
      } else {
        return Future.error(RequestError(
          -1,
          exception.toString(),
          exception,
        ));
      }
    }
  }
}
