import '../../services/models/task_get_datasource_model.dart';

abstract class DataSource {
  Future<List<TaskGetResponseDataSourceModel>?> get({
    required TaskGetRequestDataSourceModel query,
  });
}
