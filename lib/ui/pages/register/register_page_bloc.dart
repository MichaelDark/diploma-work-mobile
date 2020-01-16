import 'package:flutter/material.dart';
import 'package:flutter_dark_arch/api/api_client.dart';
import 'package:flutter_dark_arch/api/model/register_request.dart';
import 'package:flutter_dark_arch/architecture/base/base_bloc.dart';
import 'package:flutter_dark_arch/architecture/utils/states.dart';
import 'package:rxdart/rxdart.dart';

class RegisterPageBloc extends BaseBloc {
  final ApiClient apiClient;

  RegisterPageBloc(this.apiClient);

  final registerSubject = BehaviorSubject<AsyncState<String>>();

  void register({@required String email, @required String name, @required String password}) {
    makeCallForSubject<String>(
      registerSubject,
      () => apiClient.register(RegisterRequest(email, name, password)),
    );
  }

  @override
  void dispose() {
    registerSubject.close();
    super.dispose();
  }
}
