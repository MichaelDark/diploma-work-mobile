import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

class DatabaseService {
  final SqfliteAdapter adapter;

  DatabaseService(this.adapter);

//  Future<MeasurementBean> getMeasurementBean() async {
//    await MeasurementBean(adapter).createTable(ifNotExists: true);
//    return MeasurementBean(adapter);
//  }
}
