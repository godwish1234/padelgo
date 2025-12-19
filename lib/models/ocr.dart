import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';

part 'ocr.g.dart';

@JsonSerializable(explicitToJson: true)
class Ocr with BaseProtocolMixin {
  String? bloodType;
  String? birthday;
  String? gender;
  String? birthPlaceBirthday;
  String? province;
  String? city;
  String? district;
  String? village;
  String? rtrw;
  String? occupation;
  String? expiryDate;
  String? nationality;
  String? address;
  String? placeOfBirth;
  String? ktpIdUrl;
  String? idNumber;
  String? maritalStatus;
  String? name;
  String? religion;
  String? msgP;
  String? codeP;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? isUserChange = false;

  Ocr({
    this.bloodType,
    this.birthday,
    this.gender,
    this.birthPlaceBirthday,
    this.province,
    this.city,
    this.district,
    this.village,
    this.rtrw,
    this.occupation,
    this.expiryDate,
    this.nationality,
    this.address,
    this.placeOfBirth,
    this.ktpIdUrl,
    this.idNumber,
    this.maritalStatus,
    this.name,
    this.religion,
    this.msgP,
    this.codeP,
  });

  factory Ocr.fromJson(Map<String, dynamic> json) {
    final ocr = _$OcrFromJson(json);
    ocr.parseBaseProtocol(json);
    return ocr;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$OcrToJson(this);
    data.addAll(getBaseProtocolJson());
    return data;
  }
}
