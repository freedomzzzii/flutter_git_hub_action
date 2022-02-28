import 'package:universal_html/html.dart';

import '../../domains/datasources/stream_datasource.dart';

class SseDatasource implements SseDatasourceStream {
  @override
  EventSource connect({required String url}) {
    return EventSource(url);
  }

  @override
  void closeConnection({required EventSource eventSource}) {
    eventSource.close();
  }
}
