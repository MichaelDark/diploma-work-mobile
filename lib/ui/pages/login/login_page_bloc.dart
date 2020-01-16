import 'package:flutter_dark_arch/api/api_client.dart';
import 'package:flutter_dark_arch/api/model/login_request.dart';
import 'package:flutter_dark_arch/architecture/base/base_bloc.dart';
import 'package:flutter_dark_arch/architecture/utils/states.dart';
import 'package:rxdart/rxdart.dart';

class LoginPageBloc extends BaseBloc {
  final ApiClient apiClient;

  LoginPageBloc(this.apiClient);

  final loginSubject = BehaviorSubject<AsyncState<String>>();

  void login(String email, String password) {
    makeCallForSubject<String>(
      loginSubject,
      () => apiClient.login(LoginRequest(email, password)),
    );
  }

  @override
  void dispose() {
    loginSubject.close();
    super.dispose();
  }
}
