import 'package:dio/dio.dart';
import '../../services/datasources/api_datasource.dart';

abstract class DataSource {
  factory DataSource({required Dio dio}) {
    return ApiDataSource(http: dio);
  }
}
