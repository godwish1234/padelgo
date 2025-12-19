import 'package:json_annotation/json_annotation.dart';

part 'contact_validation_request.g.dart';

@JsonSerializable(explicitToJson: true)
class ContactValidationRequest {
  List<ContactValidationItem> contactList;

  ContactValidationRequest({
    required this.contactList,
  });

  factory ContactValidationRequest.fromJson(Map<String, dynamic> json) =>
      _$ContactValidationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ContactValidationRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ContactValidationItem {
  String name;
  String phone;
  int contactType;

  ContactValidationItem({
    required this.name,
    required this.phone,
    required this.contactType,
  });

  factory ContactValidationItem.fromJson(Map<String, dynamic> json) =>
      _$ContactValidationItemFromJson(json);

  Map<String, dynamic> toJson() => _$ContactValidationItemToJson(this);
}
