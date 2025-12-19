import 'package:json_annotation/json_annotation.dart';

part 'enumerations_response.g.dart';

@JsonSerializable(explicitToJson: true)
class EnumerationsResponse {
  String? code;
  @JsonKey(name: 'trace_id')
  String? traceId;
  String? msg;
  EnumerationsData? data;
  String? timestamp;
  bool? success;

  EnumerationsResponse({
    this.code,
    this.traceId,
    this.msg,
    this.data,
    this.timestamp,
    this.success,
  });

  factory EnumerationsResponse.fromJson(Map<String, dynamic> json) =>
      _$EnumerationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EnumerationsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EnumerationsData {
  Map<String, String>? gender;
  Map<String, String>? maritalStatus;
  Map<String, String>? loanPurpose;
  Map<String, String>? religions;
  Map<String, String>? educationLevels;
  Map<String, String>? workExperiences;
  Map<String, String>? workTypes;
  Map<String, String>? contactType;

  EnumerationsData({
    this.gender,
    this.maritalStatus,
    this.loanPurpose,
    this.religions,
    this.educationLevels,
    this.workExperiences,
    this.workTypes,
    this.contactType
  });

  factory EnumerationsData.fromJson(Map<String, dynamic> json) =>
      _$EnumerationsDataFromJson(json);

  Map<String, dynamic> toJson() => _$EnumerationsDataToJson(this);
}
