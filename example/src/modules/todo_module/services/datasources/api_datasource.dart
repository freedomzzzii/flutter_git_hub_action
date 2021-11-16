import 'package:dio/dio.dart';

import '../../../../utils/error_code/error_code_util.dart';
import '../../commons/errors/datasource_error.dart';
import '../../domains/datasources/datasource.dart';
import '../commons/response_json_key.dart';
import '../models/task_get_datasource_model.dart';

class ApiDataSource implements DataSource {
  ApiDataSource({required Dio http}) : _http = http;

  final Dio _http;

  Dio get http => _http;

  String? _getErrorMessage(DioError json) {
    final Map<String, List<Map<String, dynamic>>> listError =
        <String, List<Map<String, dynamic>>>{
      errorsJsonKey: (json.response?.data?[errorsJsonKey] ??
          <Map<String, dynamic>>[]) as List<Map<String, dynamic>>,
    };

    return listError[errorsJsonKey]
        ?.map((Map<String, dynamic> e) => e[titleJsonKey])
        .join(', ');
  }

  @override
  Future<List<TaskGetResponseDataSourceModel>?> get({
    required TaskGetRequestDataSourceModel query,
  }) async {
    try {
      final Response<dynamic> response = await _http.get(
        'some url',
      );

      return (response.data[dataJsonKey] as List<Object>?)?.map((Object data) {
        return TaskGetResponseDataSourceModel.fromJson(
          data as Map<String, dynamic>,
        );
      }).toList();
    } on DioError catch (e) {
      throw DataSourceError(
        message: _getErrorMessage(e) ?? e.toString(),
        code: getAppErrorCode(code: e.response?.statusCode),
      );
    } catch (e) {
      throw DataSourceError(
        message: e.toString(),
        code: appErrorCodes.unknownError,
      );
    }
  }
}
