import 'package:web_socket_channel/web_socket_channel.dart';

abstract class TaskWebSocketUseCase {
  WebSocketChannel connect({required String url});

  void close({required WebSocketChannel channel});

  void add({required WebSocketChannel channel, required dynamic data});
}
