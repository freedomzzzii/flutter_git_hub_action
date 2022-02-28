import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/domains/datasources/future_datasource.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/domains/datasources/stream_datasource.dart';
import 'package:web_socket_channel/src/channel.dart';

import '../../../../commons/constants/api_constant.dart';
import '../../../../commons/constants/env_constant.dart';
import '../../../../utils/error_code/error_code_util.dart';
import '../../commons/errors/datasource_error.dart';
import '../commons/response_json_key.dart';
import '../models/task_create_datasource_model.dart';
import '../models/task_delete_datasource_model.dart';
import '../models/task_get_datasource_model.dart';
import '../models/task_update_datasource_model.dart';

class ApiDataSource implements FutureDataSource, StreamDatasource {
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
  Future<TaskCreateResponseDataSourceModel> create({
    required TaskCreateRequestDataSourceModel task,
  }) async {
    try {
      final Response<dynamic> response = await _http.post(
        '${dotenv.env[apiUrlEnv]}$taskResourceApi',
        data: TaskCreateRequestDataSourceModel(
          title: task.title,
          imageUrl: task.imageUrl,
        ).toJsonString(),
      );

      return TaskCreateResponseDataSourceModel.fromJson(
        response.data as Map<String, dynamic>,
      );
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

  @override
  Future<List<TaskGetResponseDataSourceModel>?> get({
    required TaskGetRequestDataSourceModel query,
  }) async {
    try {
      final Response<dynamic> response = await _http.get(
        '''
${dotenv.env[apiUrlEnv]}$taskResourceApi${TaskGetRequestDataSourceModel(sortBy: query.sortBy, orderBy: query.orderBy).toQueryString()}''',
      );

      return (response.data[dataJsonKey] as List<dynamic>?)
          ?.map((dynamic data) {
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

  @override
  Future<TaskUpdateResponseDataSourceModel> update({
    required TaskUpdateQueryParamsRequestDataSourceModel queryParams,
    required TaskUpdateRequestDataSourceModel task,
  }) async {
    try {
      final String id = queryParams.id;
      final Response<dynamic> response = await _http.patch(
        '${dotenv.env[apiUrlEnv]}$taskResourceApi/$id',
        data: TaskUpdateRequestDataSourceModel(
          title: task.title,
          isDone: task.isDone,
          imageUrl: task.imageUrl,
        ).toJsonString(),
      );

      return TaskUpdateResponseDataSourceModel.fromJson(
        response.data as Map<String, dynamic>,
      );
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

  @override
  Future<void> delete({
    required TaskDeleteQueryParamsRequestDataSourceModel queryParams,
  }) async {
    try {
      final String id = queryParams.id;
      await _http.delete('${dotenv.env[apiUrlEnv]}$taskResourceApi/$id');
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

  @override
  Future<dynamic> close({required WebSocketChannel channel}) {
    try {
      return channel.sink.close();
    } catch (e) {
      throw DataSourceError(
        message: e.toString(),
        code: appErrorCodes.unknownError,
      );
    }
  }

  @override
  WebSocketChannel initConnection({required String url}) {
    try {
      final WebSocketChannel channel = WebSocketChannel.connect(Uri.parse(url));
      return channel;
    } catch (e) {
      throw DataSourceError(
        message: e.toString(),
        code: appErrorCodes.unknownError,
      );
    }
  }

  @override
  void send({required WebSocketChannel channel, required dynamic data}) {
    try {
      channel.sink.add(data);
    } catch (e) {
      throw DataSourceError(
        message: e.toString(),
        code: appErrorCodes.unknownError,
      );
    }
  }
}
