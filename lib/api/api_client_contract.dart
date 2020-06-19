import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_work_mobile/models/plant_node.dart';
import 'package:graduation_work_mobile/models/plant_request.dart';
import 'package:graduation_work_mobile/models/plant_request_node.dart';

import 'model/forgot_password_request.dart';
import 'model/login_request.dart';
import 'model/register_request.dart';

abstract class ApiClientContract {
  Future<String> register(RegisterRequest request);

  Future<String> login(LoginRequest request);

  Future<String> forgotPassword(ForgotPasswordRequest request);

  Future<List<PlantNode>> getPlantNodes([LatLng location]);

  Future<PlantNode> getPlantNode(int id, bool isArea);

  Future<void> addPlantRequest(PlantRequest request);

  Future<List<PlantRequestNode>> getPlantRequestNodes([LatLng location]);

//  Future<PlantRequestNode> getPlantRequest(int id);
//
//  Future<void> approvePlantRequest(int id);
//
//  Future<void> declinePlantRequest(int id);
//
//  Future<void> grantModerator(int userId);
}
