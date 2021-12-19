import 'package:universal_html/html.dart';

abstract class TaskSseRepository {
  EventSource get();

  void closeConnection({required EventSource eventSource});
}
