import 'package:universal_html/html.dart';

abstract class SseDatasourceStream {
  EventSource connect({required String url});

  void closeConnection({required EventSource eventSource});
}
