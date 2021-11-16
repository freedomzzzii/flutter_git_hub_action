import 'package:faker/faker.dart';

import '../../helpers/check_os/check_os_helper.dart';
import '../../modules/todo_module/applications/bloc/task_bloc/task_bloc.dart';
import '../../modules/todo_module/applications/models/error_bloc_model.dart';
import '../../modules/todo_module/applications/models/exception_bloc_model.dart';
import '../../modules/todo_module/applications/models/task_bloc_models/task_create_bloc_model.dart';
import '../../modules/todo_module/applications/models/task_bloc_models/task_delete_bloc_model.dart';
import '../../modules/todo_module/applications/models/task_bloc_models/task_get_bloc_model.dart';
import '../../modules/todo_module/applications/models/task_bloc_models/task_update_bloc_model.dart';
import '../../modules/todo_module/commons/errors/datasource_error.dart';
import '../../modules/todo_module/commons/errors/repository_error.dart';
import '../../modules/todo_module/commons/errors/usecase_error.dart';
import '../../modules/todo_module/commons/exceptions/usecase_exception.dart';
import '../../modules/todo_module/configs/grpc/task.pbgrpc.dart';
import '../../modules/todo_module/configs/usecasae_messages/usecase_message_config.dart';
import '../../modules/todo_module/domains/entities/task_create_entity.dart';
import '../../modules/todo_module/domains/entities/task_delete_entity.dart';
import '../../modules/todo_module/domains/entities/task_get_entity.dart';
import '../../modules/todo_module/domains/entities/task_update_entity.dart';
import '../../modules/todo_module/services/commons/request_query.dart';
import '../../modules/todo_module/services/models/task_create_datasource_model.dart';
import '../../modules/todo_module/services/models/task_delete_datasource_model.dart';
import '../../modules/todo_module/services/models/task_get_datasource_model.dart';
import '../../modules/todo_module/services/models/task_update_datasource_model.dart';
import '../error_code/error_code_util.dart';
import '../firebase_message/firebase_message_util.dart';
import '../grpc/grpc_util.dart';
import '../image_picker/image_picker_util.dart';

final Faker faker = Faker();

final TaskGetResponseEntity expectTaskGetResponseEntity = TaskGetResponseEntity(
  id: faker.guid.toString(),
  title: faker.person.name(),
  imageUrl: '''
iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=''',
  isDone: false,
  createdAt: faker.date.dateTime(),
);

final TaskCreateResponseEntity expectTaskCreateResponseEntity =
    TaskCreateResponseEntity(
  id: expectTaskGetResponseEntity.id,
  title: expectTaskGetResponseEntity.title,
  imageUrl: expectTaskGetResponseEntity.imageUrl,
  isDone: expectTaskGetResponseEntity.isDone,
  createdAt: expectTaskGetResponseEntity.createdAt,
);

final List<TaskGetResponseEntity> expectTaskGetResponseEntityList =
    <TaskGetResponseEntity>[expectTaskGetResponseEntity];

const TaskGetRequestEntity expectTaskGetRequestEntity = TaskGetRequestEntity(
  sortBy: createdAtQueryValue,
  orderBy: descQueryValue,
);

final DataSourceError expectDataSourceError = DataSourceError(
  message: faker.lorem.word(),
  code: appErrorCodes.missingRequiredFields,
);

final ImagePickerUtilError expectImagePickerUtilError = ImagePickerUtilError(
  message: expectDataSourceError.message,
  code: expectDataSourceError.code,
);

final RepositoryError expectRepositoryError = RepositoryError(
  message: expectDataSourceError.message,
  code: expectDataSourceError.code,
);

final TaskGetResponseDataSourceModel expectTaskGetResponseDataSourceModel =
    TaskGetResponseDataSourceModel(
  id: expectTaskGetResponseEntity.id,
  title: expectTaskGetResponseEntity.title,
  isDone: expectTaskGetResponseEntity.isDone,
  imageUrl: expectTaskGetResponseEntity.imageUrl,
  createdAt: expectTaskGetResponseEntity.createdAt,
);

final List<TaskGetResponseDataSourceModel>
    expectTaskGetResponseDataSourceModelList = <TaskGetResponseDataSourceModel>[
  expectTaskGetResponseDataSourceModel
];

final TaskGetRequestDataSourceModel expectTaskGetRequestDataSourceModel =
    TaskGetRequestDataSourceModel(
  sortBy: expectTaskGetRequestEntity.sortBy,
  orderBy: expectTaskGetRequestEntity.orderBy,
);

final String expectTaskGetRequestDataSourceModelString =
    TaskGetRequestDataSourceModel(
  sortBy: expectTaskGetRequestDataSourceModel.sortBy,
  orderBy: expectTaskGetRequestDataSourceModel.orderBy,
).toQueryString();

final TaskGetUseCaseError expectTaskGetUseCaseError = TaskGetUseCaseError(
  message: expectDataSourceError.message,
  code: expectDataSourceError.code,
);

final TaskGetRequestBlocModel expectTaskGetRequestBlocModel =
    TaskGetRequestBlocModel(
  sortBy: expectTaskGetRequestEntity.sortBy,
  orderBy: expectTaskGetRequestEntity.orderBy,
);

final TaskGetResponseBlocModel expectTaskGetResponseBlocModel =
    TaskGetResponseBlocModel(
  id: expectTaskGetResponseEntity.id,
  title: expectTaskGetResponseEntity.title,
  isDone: expectTaskGetResponseEntity.isDone,
  imageUrl: expectTaskGetResponseEntity.imageUrl,
  createdAt: expectTaskGetResponseEntity.createdAt,
);

final List<TaskGetResponseBlocModel> expectTaskGetResponseBlocModelList =
    <TaskGetResponseBlocModel>[expectTaskGetResponseBlocModel];

final ExceptionBlocModel exceptExceptionBlocModel = ExceptionBlocModel(
  message: expectDataSourceError.message,
  code: expectDataSourceError.code,
);

final ErrorBlocModel exceptErrorBlocModel = ErrorBlocModel(
  message: expectDataSourceError.message,
  code: expectDataSourceError.code,
);

final DataSourceError expectDataSourceErrorRequiredField = DataSourceError(
  message: expectDataSourceError.message,
  code: expectDataSourceError.code,
);

final TaskCreateRequestBlocModel expectTaskCreateRequestBlocModel =
    TaskCreateRequestBlocModel(
  title: expectTaskCreateResponseEntity.title,
  imageUrl: expectTaskCreateResponseEntity.imageUrl,
);

final TaskCreateResponseBlocModel expectTaskCreateResponseBlocModel =
    TaskCreateResponseBlocModel(
  id: expectTaskCreateResponseEntity.id,
  title: expectTaskCreateResponseEntity.title,
  isDone: expectTaskCreateResponseEntity.isDone,
  imageUrl: expectTaskCreateResponseEntity.imageUrl,
  createdAt: expectTaskCreateResponseEntity.createdAt,
);

final TaskCreateRequestDataSourceModel expectTaskCreateRequestDataSourceModel =
    TaskCreateRequestDataSourceModel(
  title: expectTaskCreateResponseEntity.title,
  imageUrl: expectTaskCreateResponseEntity.imageUrl,
);

final TaskCreateResponseDataSourceModel
    expectTaskCreateResponseDataSourceModel = TaskCreateResponseDataSourceModel(
  id: expectTaskCreateResponseEntity.id,
  title: expectTaskCreateResponseEntity.title,
  isDone: expectTaskCreateResponseEntity.isDone,
  imageUrl: expectTaskCreateResponseEntity.imageUrl,
  createdAt: expectTaskCreateResponseEntity.createdAt,
);

final TaskCreateRequestEntity expectTaskCreateRequestEntity =
    TaskCreateRequestEntity(
  title: expectTaskCreateResponseEntity.title,
  imageUrl: expectTaskCreateResponseEntity.imageUrl,
);

final TaskInitialState expectTaskInitialState = TaskInitialState();

final TaskGetState expectTaskGetState = TaskGetState(
  status: taskStatusState.failure,
  query: expectTaskGetRequestBlocModel,
  data: expectTaskGetResponseBlocModelList,
  error: exceptErrorBlocModel,
  exception: exceptExceptionBlocModel,
);

final TaskGetState expectTaskGetStateSuccess = TaskGetState(
  status: taskStatusState.success,
  query: expectTaskGetRequestBlocModel,
  data: expectTaskGetResponseBlocModelList,
);

final TaskGetState expectTaskGetStateSuccessDataEmpty = TaskGetState(
  status: taskStatusState.success,
  query: expectTaskGetRequestBlocModel,
);

final TaskGetState expectTaskGetStateError = TaskGetState(
  status: taskStatusState.failure,
  query: expectTaskGetRequestBlocModel,
  error: exceptErrorBlocModel,
);

final TaskUpdateBodyRequestEntity expectTaskUpdateRequestEntity =
    TaskUpdateBodyRequestEntity(
  title: expectTaskGetResponseEntity.title,
  isDone: expectTaskGetResponseEntity.isDone,
  imageUrl: expectTaskGetResponseEntity.imageUrl,
);

final TaskUpdateResponseEntity expectTaskUpdateResponseEntity =
    TaskUpdateResponseEntity(
  id: expectTaskGetResponseEntity.id,
  title: expectTaskGetResponseEntity.title,
  isDone: expectTaskGetResponseEntity.isDone,
  imageUrl: expectTaskGetResponseEntity.imageUrl,
  createdAt: expectTaskGetResponseEntity.createdAt,
);

final TaskUpdateQueryParamsRequestEntity
    expectTaskUpdateQueryParamsRequestEntity =
    TaskUpdateQueryParamsRequestEntity(
  id: expectTaskGetResponseEntity.id,
);

final TaskDeleteQueryParamsRequestEntity
    expectTaskDeleteQueryParamsRequestEntity =
    TaskDeleteQueryParamsRequestEntity(id: expectTaskGetResponseEntity.id);

final TaskUpdateResponseDataSourceModel
    expectTaskUpdateResponseDataSourceModel = TaskUpdateResponseDataSourceModel(
  id: expectTaskGetResponseEntity.id,
  title: expectTaskGetResponseEntity.title,
  isDone: expectTaskGetResponseEntity.isDone,
  imageUrl: expectTaskGetResponseEntity.imageUrl,
  createdAt: expectTaskGetResponseEntity.createdAt,
);

final TaskUpdateRequestDataSourceModel expectTaskUpdateRequestDataSourceModel =
    TaskUpdateRequestDataSourceModel(
  title: expectTaskGetResponseEntity.title,
  isDone: expectTaskGetResponseEntity.isDone,
  imageUrl: expectTaskGetResponseEntity.imageUrl,
);
final TaskCreateState expectTaskCreateState = TaskCreateState(
  error: exceptErrorBlocModel,
  status: taskStatusState.failure,
  exception: exceptExceptionBlocModel,
);

final FieldValidationException expectTaskFieldValidationExceptionTitleEmpty =
    FieldValidationException(
  message: requiredTitleMessage,
  code: expectDataSourceError.code,
);

final FieldValidationException expectTaskFieldValidationExceptionImageUrlEmpty =
    FieldValidationException(
  message: requiredImageUrlMessage,
  code: expectDataSourceError.code,
);

final FieldValidationException expectFieldValidationExceptionTitleEmpty =
    FieldValidationException(
  message: requiredTitleMessage,
  code: expectDataSourceError.code,
);

const FieldRequiredException expectFieldRequiredExceptionId =
    FieldRequiredException(
  message: requiredIdMessage,
  code: appErrorCodes.missingRequiredFields,
);

const FieldValidationException expectFieldValidationExceptionAtLeastOne =
    FieldValidationException(
  message: requiredAtLeastOneMessage,
  code: appErrorCodes.missingRequiredFields,
);

const TaskCreateState expectTaskCreateStateSuccess =
    TaskCreateState(status: taskStatusState.success);

final TaskCreateUseCaseError expectTaskCreateUseCaseError =
    TaskCreateUseCaseError(
  message: expectDataSourceError.message,
  code: expectDataSourceError.code,
);

final TaskUpdateQueryParamsRequestDataSourceModel
    expectTaskUpdateQueryParamsRequestDataSourceModel =
    TaskUpdateQueryParamsRequestDataSourceModel(
  id: expectTaskGetResponseEntity.id,
);

final TaskUpdateState expectTaskUpdateStateSuccess = TaskUpdateState(
  data: expectTaskUpdateBlocModel,
  status: taskStatusState.success,
);

final TaskUpdateBlocModel expectTaskUpdateBlocModel = TaskUpdateBlocModel(
  id: expectTaskCreateResponseEntity.id,
  title: expectTaskCreateResponseEntity.title,
  isDone: expectTaskCreateResponseEntity.isDone,
  imageUrl: expectTaskCreateResponseEntity.imageUrl,
);

final TaskSelectedToUpdatedEvent expectTaskSelectedToUpdateEvent =
    TaskSelectedToUpdatedEvent(model: expectTaskUpdateBlocModel);

final TaskUpdateUseCaseError expectTaskUpdateUseCaseError =
    TaskUpdateUseCaseError(
  message: expectDataSourceError.message,
  code: expectDataSourceError.code,
);

final TaskDeleteUseCaseError expectTaskDeleteUseCaseError =
    TaskDeleteUseCaseError(
  message: expectDataSourceError.message,
  code: expectDataSourceError.code,
);

final TaskUpdateQueryParamsRequestBlocModel
    expectTaskUpdateQueryParamsRequestBlocModel =
    TaskUpdateQueryParamsRequestBlocModel(id: expectTaskGetResponseEntity.id);

final TaskUpdateResponseBlocModel expectTaskUpdateResponseBlocModel =
    TaskUpdateResponseBlocModel(
  id: expectTaskGetResponseEntity.id,
  title: expectTaskGetResponseEntity.title,
  isDone: expectTaskGetResponseEntity.isDone,
  imageUrl: expectTaskGetResponseEntity.imageUrl,
  createdAt: expectTaskGetResponseEntity.createdAt,
);

final TaskDeleteQueryParamsRequestBlocModel
    expectTaskDeleteQueryParamsRequestBlocModel =
    TaskDeleteQueryParamsRequestBlocModel(id: expectTaskGetResponseEntity.id);

final TaskUpdateBodyRequestBlocModel expectTaskUpdateBodyRequestBlocModel =
    TaskUpdateBodyRequestBlocModel(
  title: expectTaskGetResponseEntity.title,
  isDone: expectTaskGetResponseEntity.isDone,
  imageUrl: expectTaskGetResponseEntity.imageUrl,
);

final TaskUpdateState expectTaskUpdateState = TaskUpdateState(
  data: expectTaskUpdateBlocModel,
  exception: exceptExceptionBlocModel,
  error: exceptErrorBlocModel,
  status: expectTaskGetState.status,
);

final TaskDeleteState expectTaskDeleteState = TaskDeleteState(
  exception: exceptExceptionBlocModel,
  error: exceptErrorBlocModel,
  status: expectTaskGetState.status,
);

final FirebaseMessagingUtilError expectFirebaseMessagingUtilError =
    FirebaseMessagingUtilError(
  message: expectDataSourceError.message,
  code: expectDataSourceError.code,
);

final LocalNotificationUtilError expectLocalNotificationUtilError =
    LocalNotificationUtilError(
  message: expectDataSourceError.message,
  code: expectDataSourceError.code,
);

final GrpcClientUtilError expectGrpcClientUtilError = GrpcClientUtilError(
  message: expectDataSourceError.message,
  code: expectDataSourceError.code,
);

final TaskFetchWithMetaDataMessage expectGetTasksResponse =
    TaskFetchWithMetaDataMessage(
  data: <Task>[
    Task(
      id: expectTaskGetResponseEntity.id,
      title: expectTaskGetResponseEntity.title,
      imageUrl: expectTaskGetResponseEntity.imageUrl,
      isDone: expectTaskGetResponseEntity.isDone,
      createdAt: expectTaskGetResponseEntity.createdAt.toString(),
    )
  ],
);

final TaskDeleteQueryParamsRequestDataSourceModel
    expectTaskDeleteQueryParamsRequestDataSourceModel =
    TaskDeleteQueryParamsRequestDataSourceModel(
  id: expectTaskGetResponseEntity.id,
);

final GetOsError expectGetOsError = GetOsError(
  message: expectDataSourceError.message,
  code: expectDataSourceError.code,
);
