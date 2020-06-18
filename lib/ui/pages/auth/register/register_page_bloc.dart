import 'package:flutter/material.dart';
import 'package:graduation_work_mobile/api/api_client.dart';
import 'package:graduation_work_mobile/api/model/login_request.dart';
import 'package:graduation_work_mobile/api/model/register_request.dart';
import 'package:graduation_work_mobile/architecture/base/base_bloc.dart';
import 'package:graduation_work_mobile/architecture/utils/states.dart';
import 'package:graduation_work_mobile/utils/storage.dart';
import 'package:rxdart/rxdart.dart';

class RegisterPageBloc extends BaseBloc {
  final ApiClient apiClient;

  RegisterPageBloc(this.apiClient);

  final registerSubject = BehaviorSubject<AsyncState<String>>();

  void register({@required String email, @required String name, @required String password}) {
    makeCallForSubject<String>(
      registerSubject,
      () async {
        await apiClient.register(RegisterRequest(email, name, password));
        await apiClient.login(LoginRequest(email, password));
        await Storage().setUserEmail(email);
        return email;
      },
    );
  }

  @override
  void dispose() {
    registerSubject.close();
    super.dispose();
  }
}
