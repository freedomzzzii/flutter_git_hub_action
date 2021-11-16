///
import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use getTasksParamsDescriptor instead')
const GetTasksParams$json = const {
  '1': 'GetTasksParams',
};

/// Descriptor for `GetTasksParams`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTasksParamsDescriptor =
    $convert.base64Decode('Cg5HZXRUYXNrc1BhcmFtcw==');
@$core.Deprecated('Use taskDescriptor instead')
const Task$json = const {
  '1': 'Task',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'imageUrl', '3': 3, '4': 1, '5': 9, '10': 'imageUrl'},
    const {'1': 'isDone', '3': 4, '4': 1, '5': 8, '10': 'isDone'},
    const {'1': 'createdAt', '3': 5, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `Task`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List taskDescriptor = $convert.base64Decode(
    'CgRUYXNrEg4KAmlkGAEgASgJUgJpZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSGgoIaW1hZ2VVcmwYAyABKAlSCGltYWdlVXJsEhYKBmlzRG9uZRgEIAEoCFIGaXNEb25lEhwKCWNyZWF0ZWRBdBgFIAEoCVIJY3JlYXRlZEF0');
@$core.Deprecated('Use taskFetchTotalRecordsMessageDescriptor instead')
const TaskFetchTotalRecordsMessage$json = const {
  '1': 'TaskFetchTotalRecordsMessage',
  '2': const [
    const {'1': 'totalRecords', '3': 1, '4': 1, '5': 3, '10': 'totalRecords'},
  ],
};

/// Descriptor for `TaskFetchTotalRecordsMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List taskFetchTotalRecordsMessageDescriptor =
    $convert.base64Decode(
        'ChxUYXNrRmV0Y2hUb3RhbFJlY29yZHNNZXNzYWdlEiIKDHRvdGFsUmVjb3JkcxgBIAEoA1IMdG90YWxSZWNvcmRz');
@$core.Deprecated('Use taskFetchMetaDataMessageDescriptor instead')
const TaskFetchMetaDataMessage$json = const {
  '1': 'TaskFetchMetaDataMessage',
  '2': const [
    const {
      '1': 'pagination',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.gRPC.TaskFetchTotalRecordsMessage',
      '10': 'pagination'
    },
  ],
};

/// Descriptor for `TaskFetchMetaDataMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List taskFetchMetaDataMessageDescriptor =
    $convert.base64Decode(
        'ChhUYXNrRmV0Y2hNZXRhRGF0YU1lc3NhZ2USQgoKcGFnaW5hdGlvbhgBIAEoCzIiLmdSUEMuVGFza0ZldGNoVG90YWxSZWNvcmRzTWVzc2FnZVIKcGFnaW5hdGlvbg==');
@$core.Deprecated('Use taskFetchWithMetaDataMessageDescriptor instead')
const TaskFetchWithMetaDataMessage$json = const {
  '1': 'TaskFetchWithMetaDataMessage',
  '2': const [
    const {
      '1': 'data',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.gRPC.Task',
      '10': 'data'
    },
    const {
      '1': 'metaData',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.gRPC.TaskFetchMetaDataMessage',
      '10': 'metaData'
    },
  ],
};

/// Descriptor for `TaskFetchWithMetaDataMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List taskFetchWithMetaDataMessageDescriptor =
    $convert.base64Decode(
        'ChxUYXNrRmV0Y2hXaXRoTWV0YURhdGFNZXNzYWdlEh4KBGRhdGEYASADKAsyCi5nUlBDLlRhc2tSBGRhdGESOgoIbWV0YURhdGEYAiABKAsyHi5nUlBDLlRhc2tGZXRjaE1ldGFEYXRhTWVzc2FnZVIIbWV0YURhdGE=');
