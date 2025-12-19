import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';

part 'contact_validation_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ContactValidationResponse with BaseProtocolMixin {
  bool isValid;
  List<String>? validationMessages;

  ContactValidationResponse({
    required this.isValid,
    this.validationMessages,
  });

  factory ContactValidationResponse.fromJson(Map<String, dynamic> json) {
    final instance = _$ContactValidationResponseFromJson(json);
    instance.parseBaseProtocol(json);
    return instance;
  }

  Map<String, dynamic> toJson() {
    final json = _$ContactValidationResponseToJson(this);
    json.addAll(getBaseProtocolJson());
    return json;
  }
}
