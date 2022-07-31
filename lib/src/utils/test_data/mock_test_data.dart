// Note. ignore rule in this file because faker is dev dependencies
// ignore: depend_on_referenced_packages
import 'package:faker/faker.dart';

import '../../core/navigation/navigation_core.dart';
import '../../helpers/check_os/check_os_helper.dart';
import '../../modules/common_module/configs/routes/route_config.dart';
import '../../modules/task_module/applications/models/error_view_model.dart';
import '../../modules/task_module/applications/models/exception_view_model.dart';
import '../../modules/task_module/applications/models/task_create_view_model.dart';
import '../../modules/task_module/applications/models/task_delete_view_model.dart';
import '../../modules/task_module/applications/models/task_get_view_model.dart';
import '../../modules/task_module/applications/models/task_update_view_model.dart';
import '../../modules/task_module/commons/errors/datasource_error.dart';
import '../../modules/task_module/commons/errors/repository_error.dart';
import '../../modules/task_module/commons/errors/usecase_error.dart';
import '../../modules/task_module/commons/exceptions/usecase_exception.dart';
import '../../modules/task_module/configs/grpc/task.pbgrpc.dart';
import '../../modules/task_module/configs/usecasae_messages/usecase_message_config.dart';
import '../../modules/task_module/domains/entities/task_create_entity.dart';
import '../../modules/task_module/domains/entities/task_delete_entity.dart';
import '../../modules/task_module/domains/entities/task_get_entity.dart';
import '../../modules/task_module/domains/entities/task_update_entity.dart';
import '../../modules/task_module/services/commons/request_query.dart';
import '../../modules/task_module/services/models/task_create_datasource_model.dart';
import '../../modules/task_module/services/models/task_delete_datasource_model.dart';
import '../../modules/task_module/services/models/task_get_datasource_model.dart';
import '../../modules/task_module/services/models/task_update_datasource_model.dart';
import '../error_code/error_code_util.dart';
import '../firebase/firebase_message_util.dart';
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
  code: AppErrorCodes.missingRequiredFields,
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

final TaskGetRequestControllerModel expectTaskGetRequestControllerModel =
    TaskGetRequestControllerModel(
  sortBy: expectTaskGetRequestEntity.sortBy,
  orderBy: expectTaskGetRequestEntity.orderBy,
);

final TaskGetResponseControllerModel expectTaskGetResponseControllerModel =
    TaskGetResponseControllerModel(
  id: expectTaskGetResponseEntity.id,
  title: expectTaskGetResponseEntity.title,
  isDone: expectTaskGetResponseEntity.isDone,
  imageUrl: expectTaskGetResponseEntity.imageUrl,
  createdAt: expectTaskGetResponseEntity.createdAt,
);

final ExceptionViewModel exceptExceptionViewModel = ExceptionViewModel(
  message: expectDataSourceError.message,
  code: expectDataSourceError.code,
);

final ErrorViewModel exceptErrorViewModel = ErrorViewModel(
  message: expectDataSourceError.message,
  code: expectDataSourceError.code,
);

final DataSourceError expectDataSourceErrorRequiredField = DataSourceError(
  message: expectDataSourceError.message,
  code: expectDataSourceError.code,
);

final TaskCreateRequestControllerModel expectTaskCreateRequestControllerModel =
    TaskCreateRequestControllerModel(
  title: expectTaskCreateResponseEntity.title,
  imageUrl: expectTaskCreateResponseEntity.imageUrl,
);

final TaskCreateResponseControllerModel
    expectTaskCreateResponseControllerModel = TaskCreateResponseControllerModel(
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

final TaskUpdateBodyRequestEntity expectTaskUpdateBodyRequestEntity =
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

final FieldValidationException expectTaskFieldValidationExceptionTitleEmpty =
    FieldValidationException(
  message: requiredTitleMessage,
  code: expectDataSourceError.code,
);

const FieldRequiredException expectFieldRequiredExceptionId =
    FieldRequiredException(
  message: requiredIdMessage,
  code: AppErrorCodes.missingRequiredFields,
);

const FieldValidationException expectFieldValidationExceptionAtLeastOne =
    FieldValidationException(
  message: requiredAtLeastOneMessage,
  code: AppErrorCodes.missingRequiredFields,
);

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

final TaskUpdateControllerModel expectTaskUpdateControllerModel =
    TaskUpdateControllerModel(
  id: expectTaskCreateResponseEntity.id,
  title: expectTaskCreateResponseEntity.title,
  isDone: expectTaskCreateResponseEntity.isDone,
  imageUrl: expectTaskCreateResponseEntity.imageUrl,
);

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

final TaskUpdateQueryParamsRequestControllerModel
    expectTaskUpdateQueryParamsRequestControllerModel =
    TaskUpdateQueryParamsRequestControllerModel(
  id: expectTaskGetResponseEntity.id,
);

final TaskUpdateResponseControllerModel
    expectTaskUpdateResponseControllerModel = TaskUpdateResponseControllerModel(
  id: expectTaskGetResponseEntity.id,
  title: expectTaskGetResponseEntity.title,
  isDone: expectTaskGetResponseEntity.isDone,
  imageUrl: expectTaskGetResponseEntity.imageUrl,
  createdAt: expectTaskGetResponseEntity.createdAt,
);

final TaskDeleteQueryParamsRequestControllerModel
    expectTaskDeleteQueryParamsRequestControllerModel =
    TaskDeleteQueryParamsRequestControllerModel(
  id: expectTaskGetResponseEntity.id,
);

final TaskUpdateBodyRequestControllerModel
    expectTaskUpdateBodyRequestControllerModel =
    TaskUpdateBodyRequestControllerModel(
  title: expectTaskGetResponseEntity.title,
  isDone: expectTaskGetResponseEntity.isDone,
  imageUrl: expectTaskGetResponseEntity.imageUrl,
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

final GrpcResponseSuccessWithMetaDataModel expectGetTasksResponse =
    GrpcResponseSuccessWithMetaDataModel(
  data: <TaskFetchResponseGrpcModel>[
    TaskFetchResponseGrpcModel(
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

final ErrorViewModel expectErrorViewModel = ErrorViewModel(
  message: expectDataSourceError.message,
  code: expectDataSourceError.code,
);

final ExceptionViewModel expectExceptionViewModel = ExceptionViewModel(
  message: expectDataSourceError.message,
  code: expectDataSourceError.code,
);

final TaskUpdateEntity expectTaskUpdateEntity = TaskUpdateEntity(
  id: expectTaskGetResponseEntity.id,
  title: expectTaskGetResponseEntity.title,
  imageUrl: expectTaskGetResponseEntity.imageUrl,
  isDone: expectTaskGetResponseEntity.isDone,
);

final SubPath expectSubPath = SubPath(
  name: expectTaskGetResponseEntity.title,
  path: commonNotFoundPath.path,
);

final NavigationError expectNavigationError = NavigationError(
  message: expectDataSourceError.message,
  code: expectDataSourceError.code,
);
