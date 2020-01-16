import 'package:graduation_work_mobile/api/api_client.dart';
import 'package:graduation_work_mobile/architecture/base/base_bloc.dart';

class HomePageBloc extends BaseBloc {
  final ApiClient apiClient;

  HomePageBloc(this.apiClient);
}
