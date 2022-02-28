import 'dart:async';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../entities/task_create_entity.dart';
import '../entities/task_delete_entity.dart';
import '../entities/task_get_entity.dart';
import '../entities/task_update_entity.dart';

abstract class TaskUseCase {
  Future<TaskCreateResponseEntity> create({
    required TaskCreateRequestEntity task,
  });

  Future<List<TaskGetResponseEntity>?> get({
    required TaskGetRequestEntity query,
  });

  Future<TaskUpdateResponseEntity> update({
    required TaskUpdateQueryParamsRequestEntity queryParams,
    required TaskUpdateBodyRequestEntity task,
  });

  Future<void> delete({
    required TaskDeleteQueryParamsRequestEntity queryParams,
  });

  WebSocketChannel streamGet({required String url});

  void sendData({required WebSocketChannel channel, required dynamic data});

  Future<dynamic> disconnect({required WebSocketChannel channel});
}
