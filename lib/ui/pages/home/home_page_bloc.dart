import 'package:flutter_dark_arch/api/api_client.dart';
import 'package:flutter_dark_arch/architecture/base/base_bloc.dart';

class HomePageBloc extends BaseBloc {
  final ApiClient apiClient;

  HomePageBloc(this.apiClient);
}
