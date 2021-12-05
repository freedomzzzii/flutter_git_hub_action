import 'package:flutter_starter_kit/src/modules/todo_module/services/datasources/sse_datasource.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:universal_html/html.dart';

class FakeSseDatasource extends Fake implements SseDatasource {
  @override
  EventSource connect({required String url}) {
    return expectEventSource;
  }
}

void main() {
  final FakeSseDatasource expectSseDatasource = FakeSseDatasource();

  group('SseDatasource Class', () {
    test('Should have SseDatasource Class', () {
      expect(SseDatasource, SseDatasource);
    });

    test('Should have connect method', () {
      expect(
        expectSseDatasource.connect(url: expectTaskGetResponseEntity.title),
        expectEventSource,
      );
    });
  });
}
