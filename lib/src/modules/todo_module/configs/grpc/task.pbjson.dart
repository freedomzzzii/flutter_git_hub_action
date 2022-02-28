///
//  Generated code. Do not modify.
//  source: task.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use taskFetchQueryParamsGrpcModelDescriptor instead')
const TaskFetchQueryParamsGrpcModel$json = const {
  '1': 'TaskFetchQueryParamsGrpcModel',
};

/// Descriptor for `TaskFetchQueryParamsGrpcModel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List taskFetchQueryParamsGrpcModelDescriptor = $convert.base64Decode('Ch1UYXNrRmV0Y2hRdWVyeVBhcmFtc0dycGNNb2RlbA==');
@$core.Deprecated('Use taskFetchResponseGrpcModelDescriptor instead')
const TaskFetchResponseGrpcModel$json = const {
  '1': 'TaskFetchResponseGrpcModel',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'imageUrl', '3': 3, '4': 1, '5': 9, '10': 'imageUrl'},
    const {'1': 'isDone', '3': 4, '4': 1, '5': 8, '10': 'isDone'},
    const {'1': 'createdAt', '3': 5, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `TaskFetchResponseGrpcModel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List taskFetchResponseGrpcModelDescriptor = $convert.base64Decode('ChpUYXNrRmV0Y2hSZXNwb25zZUdycGNNb2RlbBIOCgJpZBgBIAEoCVICaWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEhoKCGltYWdlVXJsGAMgASgJUghpbWFnZVVybBIWCgZpc0RvbmUYBCABKAhSBmlzRG9uZRIcCgljcmVhdGVkQXQYBSABKAlSCWNyZWF0ZWRBdA==');
@$core.Deprecated('Use taskFetchTotalRecordsResponseGrpcModelDescriptor instead')
const TaskFetchTotalRecordsResponseGrpcModel$json = const {
  '1': 'TaskFetchTotalRecordsResponseGrpcModel',
  '2': const [
    const {'1': 'totalRecords', '3': 1, '4': 1, '5': 3, '10': 'totalRecords'},
  ],
};

/// Descriptor for `TaskFetchTotalRecordsResponseGrpcModel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List taskFetchTotalRecordsResponseGrpcModelDescriptor = $convert.base64Decode('CiZUYXNrRmV0Y2hUb3RhbFJlY29yZHNSZXNwb25zZUdycGNNb2RlbBIiCgx0b3RhbFJlY29yZHMYASABKANSDHRvdGFsUmVjb3Jkcw==');
@$core.Deprecated('Use taskFetchMetaDataResponseGrpcModelDescriptor instead')
const TaskFetchMetaDataResponseGrpcModel$json = const {
  '1': 'TaskFetchMetaDataResponseGrpcModel',
  '2': const [
    const {'1': 'pagination', '3': 1, '4': 1, '5': 11, '6': '.gRPC.TaskFetchTotalRecordsResponseGrpcModel', '10': 'pagination'},
  ],
};

/// Descriptor for `TaskFetchMetaDataResponseGrpcModel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List taskFetchMetaDataResponseGrpcModelDescriptor = $convert.base64Decode('CiJUYXNrRmV0Y2hNZXRhRGF0YVJlc3BvbnNlR3JwY01vZGVsEkwKCnBhZ2luYXRpb24YASABKAsyLC5nUlBDLlRhc2tGZXRjaFRvdGFsUmVjb3Jkc1Jlc3BvbnNlR3JwY01vZGVsUgpwYWdpbmF0aW9u');
@$core.Deprecated('Use grpcResponseSuccessWithMetaDataModelDescriptor instead')
const GrpcResponseSuccessWithMetaDataModel$json = const {
  '1': 'GrpcResponseSuccessWithMetaDataModel',
  '2': const [
    const {'1': 'data', '3': 1, '4': 3, '5': 11, '6': '.gRPC.TaskFetchResponseGrpcModel', '10': 'data'},
    const {'1': 'metaData', '3': 2, '4': 1, '5': 11, '6': '.gRPC.TaskFetchMetaDataResponseGrpcModel', '10': 'metaData'},
  ],
};

/// Descriptor for `GrpcResponseSuccessWithMetaDataModel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List grpcResponseSuccessWithMetaDataModelDescriptor = $convert.base64Decode('CiRHcnBjUmVzcG9uc2VTdWNjZXNzV2l0aE1ldGFEYXRhTW9kZWwSNAoEZGF0YRgBIAMoCzIgLmdSUEMuVGFza0ZldGNoUmVzcG9uc2VHcnBjTW9kZWxSBGRhdGESRAoIbWV0YURhdGEYAiABKAsyKC5nUlBDLlRhc2tGZXRjaE1ldGFEYXRhUmVzcG9uc2VHcnBjTW9kZWxSCG1ldGFEYXRh');
