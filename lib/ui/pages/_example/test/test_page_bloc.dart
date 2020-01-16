import 'dart:math';

import 'package:flutter_dark_arch/api/api_client.dart';
import 'package:flutter_dark_arch/architecture/base/base_bloc.dart';
import 'package:flutter_dark_arch/architecture/utils/states.dart';
import 'package:flutter_dark_arch/models/home_item.dart';
import 'package:rxdart/rxdart.dart';

class TestPageBloc extends BaseBloc {
  final ApiClient apiClient;

  TestPageBloc(this.apiClient);

  final homeItemSubject = BehaviorSubject<AsyncState<List<HomeItem>>>();

  void loadHomeItems() {
    makeCallForSubject(homeItemSubject, () async {
      await Future.delayed(Duration(seconds: 2));
      return [
        HomeItem(1, 'title', 'desc', 'url'),
        HomeItem(2, 'title', 'desc', 'url'),
        HomeItem(3, 'title', 'desc', 'url'),
        HomeItem(4, 'title', 'desc', 'url'),
        HomeItem(5, 'title', 'desc', 'url'),
        HomeItem(6, 'title', 'desc', 'url'),
        HomeItem(7, 'title', 'desc', 'url'),
        HomeItem(8, 'title', 'desc', 'url'),
        HomeItem(9, 'title', 'desc', 'url'),
      ];
    });
  }

  Subject<AsyncState<HomeItem>> loadHomeItemById(int id) {
    return makeCall(() async {
      await Future.delayed(Duration(seconds: Random().nextInt(4) + 1));
      return HomeItem(id, 'title', 'desc', 'url');
    });
  }

  @override
  void dispose() {
    homeItemSubject.close();
    super.dispose();
  }
}
