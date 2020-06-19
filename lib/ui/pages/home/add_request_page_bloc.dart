import 'package:graduation_work_mobile/api/api_client.dart';
import 'package:graduation_work_mobile/architecture/base/base_bloc.dart';
import 'package:graduation_work_mobile/architecture/utils/states.dart';
import 'package:graduation_work_mobile/models/plant_request.dart';
import 'package:rxdart/rxdart.dart';

class AddRequestPageBloc extends BaseBloc {
  final ApiClient apiClient;

  AddRequestPageBloc(this.apiClient);

  final createSubject = BehaviorSubject<AsyncState<void>>();

  void createPlantRequest(PlantRequest request) {
    makeCallForSubject<void>(
      createSubject,
      () => apiClient.addPlantRequest(request),
    );
  }

  @override
  void dispose() {
    createSubject.close();
    super.dispose();
  }
}
