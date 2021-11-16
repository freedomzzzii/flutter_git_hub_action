import '../../services/models/task_create_datasource_model.dart';
import '../../services/models/task_delete_datasource_model.dart';
import '../../services/models/task_get_datasource_model.dart';
import '../../services/models/task_update_datasource_model.dart';

abstract class DataSource {
  Future<TaskCreateResponseDataSourceModel> create({
    required TaskCreateRequestDataSourceModel task,
  });

  Future<List<TaskGetResponseDataSourceModel>?> get({
    required TaskGetRequestDataSourceModel query,
  });

  Future<TaskUpdateResponseDataSourceModel> update({
    required TaskUpdateQueryParamsRequestDataSourceModel queryParams,
    required TaskUpdateRequestDataSourceModel task,
  });

  Future<void> delete({
    required TaskDeleteQueryParamsRequestDataSourceModel queryParams,
  });
}
