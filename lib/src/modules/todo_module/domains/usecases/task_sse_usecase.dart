import 'package:universal_html/html.dart';

abstract class TaskSseUseCase {
  EventSource get();

  void closeConnection({required EventSource eventSource});
}
