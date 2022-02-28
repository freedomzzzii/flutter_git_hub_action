import 'dart:async';

import 'package:universal_html/html.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'datasource.dart';

abstract class SseDatasourceStream {
  EventSource connect({required String url});

  void closeConnection({required EventSource eventSource});
}

abstract class StreamDatasource implements DataSource {

  WebSocketChannel initConnection({required String url});

  void send({required WebSocketChannel channel,required dynamic data});

  Future<dynamic> close({required WebSocketChannel channel});

}
