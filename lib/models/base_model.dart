import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BaseResponse<T> extends Object with _$BaseResponseSerializerMixin {
  bool status;
  String message;
  String type;
  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  T data;

  BaseResponse(this.status, this.message, this.data, this.type);

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson<T>(json);
}

T _dataFromJson<T>(Map<String, dynamic> input) => input as T;

Map<String, dynamic> _dataToJson<T>(T input) => {'value': input};

BaseResponse<T> _$BaseResponseFromJson<T>(Map<String, dynamic> json) {
  return new BaseResponse<T>(
      json['status'] as bool,
      json['message'] as String,
      json['data'] == null
          ? null
          : _dataFromJson(json['data'] as Map<String, dynamic>),
      json['type'] as String);
}

abstract class _$BaseResponseSerializerMixin<T> {
  bool get status;
  String get message;
  String get type;
  T get data;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status,
        'message': message,
        'data': data == null ? null : _dataToJson(data),
        'type': type
      };
}
