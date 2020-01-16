import 'package:graduation_work_mobile/api/api_client.dart';
import 'package:graduation_work_mobile/api/model/forgot_password_request.dart';
import 'package:graduation_work_mobile/architecture/base/base_bloc.dart';
import 'package:graduation_work_mobile/architecture/utils/states.dart';
import 'package:rxdart/rxdart.dart';

class ForgotPasswordPageBloc extends BaseBloc {
  final ApiClient apiClient;

  ForgotPasswordPageBloc(this.apiClient);

  final forgotPasswordSubject = BehaviorSubject<AsyncState<String>>();

  void forgotPassword(String email) {
    makeCallForSubject<String>(
      forgotPasswordSubject,
      () => apiClient.forgotPassword(ForgotPasswordRequest(email)),
    );
  }

  @override
  void dispose() {
    forgotPasswordSubject.close();
    super.dispose();
  }
}
