import 'package:graduation_work_mobile/api/api_client.dart';
import 'package:graduation_work_mobile/architecture/base/base_bloc.dart';
import 'package:graduation_work_mobile/architecture/utils/states.dart';
import 'package:rxdart/rxdart.dart';

class ReviewRequestPageBloc extends BaseBloc {
  final ApiClient apiClient;

  ReviewRequestPageBloc(this.apiClient);

  final userGrantSubject = BehaviorSubject<AsyncState<void>>();
  final actionSubject = BehaviorSubject<AsyncState<void>>();

  void approve(int requestNodeId) {
    makeCallForSubject<void>(
      actionSubject,
      () => apiClient.approvePlantRequest(requestNodeId),
    );
  }

  void decline(int requestNodeId) {
    makeCallForSubject<void>(
      actionSubject,
      () => apiClient.declinePlantRequest(requestNodeId),
    );
  }

  void grantModerator(int userId) {
    makeCallForSubject<void>(
      userGrantSubject,
      () => apiClient.grantModerator(userId),
    );
  }

  @override
  void dispose() {
    userGrantSubject.close();
    actionSubject.close();
    super.dispose();
  }
}
