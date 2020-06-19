import 'package:graduation_work_mobile/api/api_client.dart';
import 'package:graduation_work_mobile/api/model/login_request.dart';
import 'package:graduation_work_mobile/architecture/base/base_bloc.dart';
import 'package:graduation_work_mobile/architecture/utils/states.dart';
import 'package:graduation_work_mobile/utils/storage.dart';
import 'package:rxdart/rxdart.dart';

class LoginPageBloc extends BaseBloc {
  final ApiClient apiClient;

  LoginPageBloc(this.apiClient);

  final loginSubject = BehaviorSubject<AsyncState<String>>();

  void login(String email, String password) {
    makeCallForSubject<String>(
      loginSubject,
      () async {
        await apiClient.login(LoginRequest(email, password));
        await Storage().setUserEmail(email);
        return email;
      },
    );
  }

  @override
  void dispose() {
    loginSubject.close();
    super.dispose();
  }
}
