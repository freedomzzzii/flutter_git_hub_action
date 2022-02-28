import 'package:dio/dio.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/services/datasources/api_datasource.dart';

abstract class DataSource {
  factory DataSource({required Dio dio}) => getDataSource(dio: dio);
}

DataSource getDataSource({required Dio dio}) {
  return ApiDataSource(http: dio);
}
