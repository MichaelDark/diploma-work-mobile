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

import 'api_service.dart';
import 'api_strings.dart';
import 'model/register_request.dart';
import 'util/error_json_converter.dart';
import 'util/example_interceptor.dart';
import 'util/jaguar_json_converter.dart';

class ApiClient {
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
    return request.email;
  }

  //TODO add API
  Future<String> login(LoginRequest request) async {
    await Future.delayed(Duration(seconds: 2));
    return request.email;
  }

  //TODO add API
  Future<String> forgotPassword(ForgotPasswordRequest request) async {
    await Future.delayed(Duration(seconds: 2));
    return request.email;
  }

  UserInfo get _mockModerator => UserInfo(
        id: 1,
        maskedEmail: 'mmm***@m**.com',
        isModerator: true,
      );

  UserInfo get _mockUser => UserInfo(
        id: 2,
        maskedEmail: 'uuu***@u**.com',
        isModerator: false,
      );

  List<PlantNode> _getNodes(LatLng location) {
    return [
      PlantNode(
        id: 1,
        title: 'Title 1',
        description: 'Description 1',
        latitude: getRandomLocation(location.latitude),
        longitude: getRandomLocation(location.longitude),
        imageUrl:
            'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1557258847-chinese-evergreen-houseplant-1557258690.jpg',
        createUser: _mockUser,
        approveUser: _mockModerator,
      ),
      PlantNode(
        id: 2,
        title: 'Title 2',
        description: 'Description 2',
        latitude: getRandomLocation(location.latitude),
        longitude: getRandomLocation(location.longitude),
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRuJDxU_mMOPlyGwDuI2BHfUizdLbynN8NLO8VNY6DI2st6OPo6&usqp=CAU',
        createUser: _mockUser,
        approveUser: _mockModerator,
        childNodes: [
          PlantNode(
            id: 3,
            title: 'Title 3',
            description: 'Description 3',
            latitude: getRandomLocation(location.latitude),
            longitude: getRandomLocation(location.longitude),
            imageUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ1KFRlpC6k3s8QSrRJlDj8lmiNpKMA5XObgMgWBXgODNJwpQDh&usqp=CAU',
            createUser: _mockUser,
            approveUser: _mockModerator,
          ),
        ],
      ),
      PlantNode(
        id: 4,
        title: 'Title 4',
        description: 'Description 4',
        latitude: getRandomLocation(location.latitude),
        longitude: getRandomLocation(location.longitude),
        imageUrl:
            'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1557258847-chinese-evergreen-houseplant-1557258690.jpg',
        createUser: _mockUser,
        approveUser: _mockModerator,
      ),
      PlantNode(
        id: 5,
        title: 'Title 5',
        description: 'Description 5',
        latitude: getRandomLocation(location.latitude),
        longitude: getRandomLocation(location.longitude),
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRuJDxU_mMOPlyGwDuI2BHfUizdLbynN8NLO8VNY6DI2st6OPo6&usqp=CAU',
        createUser: _mockUser,
        approveUser: _mockModerator,
        childNodes: [
          PlantNode(
            id: 6,
            title: 'Title 6',
            description: 'Description 6',
            latitude: getRandomLocation(location.latitude),
            longitude: getRandomLocation(location.longitude),
            imageUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ1KFRlpC6k3s8QSrRJlDj8lmiNpKMA5XObgMgWBXgODNJwpQDh&usqp=CAU',
            createUser: _mockUser,
            approveUser: _mockModerator,
          ),
          PlantNode(
            id: 7,
            title: 'Title 7',
            description: 'Description 7',
            latitude: getRandomLocation(location.latitude),
            longitude: getRandomLocation(location.longitude),
            imageUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ1KFRlpC6k3s8QSrRJlDj8lmiNpKMA5XObgMgWBXgODNJwpQDh&usqp=CAU',
            createUser: _mockUser,
            approveUser: _mockModerator,
          ),
          PlantNode(
            id: 6,
            title: 'Title 8',
            description: 'Description 8',
            latitude: getRandomLocation(location.latitude),
            longitude: getRandomLocation(location.longitude),
            imageUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ1KFRlpC6k3s8QSrRJlDj8lmiNpKMA5XObgMgWBXgODNJwpQDh&usqp=CAU',
            createUser: _mockUser,
            approveUser: _mockModerator,
          ),
          PlantNode(
            id: 9,
            title: 'Title 9',
            description: 'Description 9',
            latitude: getRandomLocation(location.latitude),
            longitude: getRandomLocation(location.longitude),
            imageUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ1KFRlpC6k3s8QSrRJlDj8lmiNpKMA5XObgMgWBXgODNJwpQDh&usqp=CAU',
            createUser: _mockUser,
            approveUser: _mockModerator,
          ),
          PlantNode(
            id: 10,
            title: 'Title 10',
            description: 'Description 10',
            latitude: getRandomLocation(location.latitude),
            longitude: getRandomLocation(location.longitude),
            imageUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ1KFRlpC6k3s8QSrRJlDj8lmiNpKMA5XObgMgWBXgODNJwpQDh&usqp=CAU',
            createUser: _mockUser,
            approveUser: _mockModerator,
          ),
        ],
      )
    ];
  }

  double getRandomLocation(double value) => value + Random().nextDouble() / 10 * (Random().nextBool() ? 1 : -1);

  LatLng get _defaultLocation => LatLng(50.015340, 36.228179);

  //TODO add API
  Future<List<PlantNode>> getPlantNodes([LatLng location]) async {
    final mockLocation = location ?? _defaultLocation;
    await Future.delayed(Duration(seconds: 2));
    return Future.value(_getNodes(mockLocation));
  }

  //TODO add API
  Future<PlantNode> getPlantNode(int id, bool isArea) async {
    await Future.delayed(Duration(milliseconds: 500));
    var node = _getNodes(_defaultLocation).firstWhere(
      (node) {
        return node.id == id || node.childNodes?.firstWhere((node) => node.id == id, orElse: () => null) != null;
      },
      orElse: () => _getNodes(_defaultLocation).first,
    );
    if (node.id != id) {
      node = node.childNodes.firstWhere(
        (node) => node.id == id,
        orElse: () => _getNodes(_defaultLocation).first,
      );
    }
    if (!isArea) {
      node.childNodes?.clear();
    }
    return Future.value(node);
  }

  //TODO add API
  Future<List<PlantRequestNode>> getPlantRequestNodes() async {
    await Future.delayed(Duration(seconds: 2));
    return Future.value(
      [
        PlantRequestNode(
          id: 1,
          description: 'Description 1',
          latitude: 50,
          longitude: 51,
          imageUrl:
              'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1557258847-chinese-evergreen-houseplant-1557258690.jpg',
        ),
        PlantRequestNode(
          id: 2,
          description: 'Description 2',
          latitude: 12,
          longitude: -56,
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRuJDxU_mMOPlyGwDuI2BHfUizdLbynN8NLO8VNY6DI2st6OPo6&usqp=CAU',
        ),
        PlantRequestNode(
          id: 3,
          description: 'Description 3',
          latitude: 52,
          longitude: 53,
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ1KFRlpC6k3s8QSrRJlDj8lmiNpKMA5XObgMgWBXgODNJwpQDh&usqp=CAU',
        ),
        PlantRequestNode(
          id: 4,
          description: 'Description 4',
          latitude: 50,
          longitude: 51,
          imageUrl:
              'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1557258847-chinese-evergreen-houseplant-1557258690.jpg',
        ),
        PlantRequestNode(
          id: 5,
          description: 'Description 5',
          latitude: 12,
          longitude: -56,
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRuJDxU_mMOPlyGwDuI2BHfUizdLbynN8NLO8VNY6DI2st6OPo6&usqp=CAU',
        ),
        PlantRequestNode(
          id: 6,
          description: 'Description 6',
          latitude: 52,
          longitude: 53,
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ1KFRlpC6k3s8QSrRJlDj8lmiNpKMA5XObgMgWBXgODNJwpQDh&usqp=CAU',
        ),
      ],
    );
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
