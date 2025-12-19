import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:padelgo/models/emergency_contact.dart';
import 'package:padelgo/models/bank_card.dart';

class PersonalInformationData {
  final int? idd;
  final String? phone;
  final String? userName;
  final String? idCard;
  final String? idCardImage;
  final String? monthIncome;
  final int? education;
  final int? religion;
  final int? childrenNum;
  final double? faceVsKtpScore;
  final int? birthday;
  final int? sex;
  final String? facePhotoImage;
  final double? confidenceScore;
  final String? motherName;
  final int? maritalStatus;
  final int? province;
  final int? city;
  final int? districts;
  final int? subDistricts;
  final String? provinceName;
  final String? cityName;
  final int? provinceCode;
  final int? cityCode;
  final String? detailAddress;
  final String? email;
  final String? whatsapp;
  final String? companyName;
  final int? workSeniority;
  final int? workType;
  final String? workDetailAddress;
  final int? payDay;
  final List<EmergencyContact>? contactList;
  final String? deviceId;
  final String? ip;
  final List<BankCard>? bankCardList;

  // UI state fields
  final String? selectedEducationName;
  final String? selectedReligionName;
  final String? selectedGenderName;
  final String? selectedMaritalStatusName;
  final String? selectedReasonName;
  final String? selectedLivingArea;
  final String? selectedPayDayName;

  PersonalInformationData({
    this.idd,
    this.phone,
    this.userName,
    this.idCard,
    this.idCardImage,
    this.monthIncome,
    this.education,
    this.religion,
    this.childrenNum,
    this.faceVsKtpScore,
    this.birthday,
    this.sex,
    this.facePhotoImage,
    this.confidenceScore,
    this.motherName,
    this.maritalStatus,
    this.province,
    this.city,
    this.districts,
    this.subDistricts,
    this.provinceName,
    this.cityName,
    this.provinceCode,
    this.cityCode,
    this.detailAddress,
    this.email,
    this.whatsapp,
    this.companyName,
    this.workSeniority,
    this.workType,
    this.workDetailAddress,
    this.payDay,
    this.contactList,
    this.deviceId,
    this.ip,
    this.bankCardList,
    this.selectedEducationName,
    this.selectedReligionName,
    this.selectedGenderName,
    this.selectedMaritalStatusName,
    this.selectedReasonName,
    this.selectedLivingArea,
    this.selectedPayDayName,
  });

  PersonalInformationData copyWith({
    int? idd,
    String? phone,
    String? userName,
    String? idCard,
    String? idCardImage,
    String? monthIncome,
    int? education,
    int? religion,
    int? childrenNum,
    double? faceVsKtpScore,
    int? birthday,
    int? sex,
    String? facePhotoImage,
    double? confidenceScore,
    String? motherName,
    int? maritalStatus,
    int? province,
    int? city,
    int? districts,
    int? subDistricts,
    String? provinceName,
    String? cityName,
    int? provinceCode,
    int? cityCode,
    String? detailAddress,
    String? email,
    String? whatsapp,
    String? companyName,
    int? workSeniority,
    int? workType,
    String? workDetailAddress,
    int? payDay,
    List<EmergencyContact>? contactList,
    String? deviceId,
    String? ip,
    List<BankCard>? bankCardList,
    String? selectedEducationName,
    String? selectedReligionName,
    String? selectedGenderName,
    String? selectedMaritalStatusName,
    String? selectedReasonName,
    String? selectedLivingArea,
    String? selectedPayDayName,
  }) {
    return PersonalInformationData(
      idd: idd ?? this.idd,
      phone: phone ?? this.phone,
      userName: userName ?? this.userName,
      idCard: idCard ?? this.idCard,
      idCardImage: idCardImage ?? this.idCardImage,
      monthIncome: monthIncome ?? this.monthIncome,
      education: education ?? this.education,
      religion: religion ?? this.religion,
      childrenNum: childrenNum ?? this.childrenNum,
      faceVsKtpScore: faceVsKtpScore ?? this.faceVsKtpScore,
      birthday: birthday ?? this.birthday,
      sex: sex ?? this.sex,
      facePhotoImage: facePhotoImage ?? this.facePhotoImage,
      confidenceScore: confidenceScore ?? this.confidenceScore,
      motherName: motherName ?? this.motherName,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      province: province ?? this.province,
      city: city ?? this.city,
      districts: districts ?? this.districts,
      subDistricts: subDistricts ?? this.subDistricts,
      provinceName: provinceName ?? this.provinceName,
      cityName: cityName ?? this.cityName,
      provinceCode: provinceCode ?? this.provinceCode,
      cityCode: cityCode ?? this.cityCode,
      detailAddress: detailAddress ?? this.detailAddress,
      email: email ?? this.email,
      whatsapp: whatsapp ?? this.whatsapp,
      companyName: companyName ?? this.companyName,
      workSeniority: workSeniority ?? this.workSeniority,
      workType: workType ?? this.workType,
      workDetailAddress: workDetailAddress ?? this.workDetailAddress,
      payDay: payDay ?? this.payDay,
      contactList: contactList ?? this.contactList,
      deviceId: deviceId ?? this.deviceId,
      ip: ip ?? this.ip,
      bankCardList: bankCardList ?? this.bankCardList,
      selectedEducationName:
          selectedEducationName ?? this.selectedEducationName,
      selectedReligionName: selectedReligionName ?? this.selectedReligionName,
      selectedGenderName: selectedGenderName ?? this.selectedGenderName,
      selectedMaritalStatusName:
          selectedMaritalStatusName ?? this.selectedMaritalStatusName,
      selectedReasonName: selectedReasonName ?? this.selectedReasonName,
      selectedLivingArea: selectedLivingArea ?? this.selectedLivingArea,
      selectedPayDayName: selectedPayDayName ?? this.selectedPayDayName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idd': idd,
      'phone': phone,
      'userName': userName,
      'idCard': idCard,
      'idCardImage': idCardImage,
      'monthIncome': monthIncome,
      'education': education,
      'religion': religion,
      'childrenNum': childrenNum,
      'faceVsKtpScore': faceVsKtpScore,
      'birthday': birthday,
      'sex': sex,
      'facePhotoImage': facePhotoImage,
      'confidenceScore': confidenceScore,
      'motherName': motherName,
      'maritalStatus': maritalStatus,
      'province': province,
      'city': city,
      'districts': districts,
      'subDistricts': subDistricts,
      'provinceName': provinceName,
      'cityName': cityName,
      'provinceCode': provinceCode,
      'cityCode': cityCode,
      'detailAddress': detailAddress,
      'email': email,
      'whatsapp': whatsapp,
      'companyName': companyName,
      'workSeniority': workSeniority,
      'workType': workType,
      'workDetailAddress': workDetailAddress,
      'payDay': payDay,
      'contactList': contactList?.map((contact) => contact.toJson()).toList(),
      'deviceId': deviceId,
      'ip': ip,
      'bankCardList': bankCardList?.map((card) => card.toJson()).toList(),
      'selectedEducationName': selectedEducationName,
      'selectedReligionName': selectedReligionName,
      'selectedGenderName': selectedGenderName,
      'selectedMaritalStatusName': selectedMaritalStatusName,
      'selectedReasonName': selectedReasonName,
      'selectedLivingArea': selectedLivingArea,
      'selectedPayDayName': selectedPayDayName,
    };
  }

  factory PersonalInformationData.fromJson(Map<String, dynamic> json) {
    return PersonalInformationData(
      idd: json['idd'] as int?,
      phone: json['phone'] as String?,
      userName: json['userName'] as String?,
      idCard: json['idCard'] as String?,
      idCardImage: json['idCardImage'] as String?,
      monthIncome: json['monthIncome'] as String?,
      education: json['education'] as int?,
      religion: json['religion'] as int?,
      childrenNum: json['childrenNum'] as int?,
      faceVsKtpScore: (json['faceVsKtpScore'] as num?)?.toDouble(),
      birthday: json['birthday'] as int?,
      sex: json['sex'] as int?,
      facePhotoImage: json['facePhotoImage'] as String?,
      confidenceScore: (json['confidenceScore'] as num?)?.toDouble(),
      motherName: json['motherName'] as String?,
      maritalStatus: json['maritalStatus'] as int?,
      province: json['province'] as int?,
      city: json['city'] as int?,
      districts: json['districts'] as int?,
      subDistricts: json['subDistricts'] as int?,
      provinceName: json['provinceName'] as String?,
      cityName: json['cityName'] as String?,
      provinceCode: json['provinceCode'] as int?,
      cityCode: json['cityCode'] as int?,
      detailAddress: json['detailAddress'] as String?,
      email: json['email'] as String?,
      whatsapp: json['whatsapp'] as String?,
      companyName: json['companyName'] as String?,
      workSeniority: json['workSeniority'] as int?,
      workType: json['workType'] as int?,
      workDetailAddress: json['workDetailAddress'] as String?,
      payDay: json['payDay'] as int?,
      contactList: (json['contactList'] as List<dynamic>?)
          ?.map((contactJson) =>
              EmergencyContact.fromJson(contactJson as Map<String, dynamic>))
          .toList(),
      deviceId: json['deviceId'] as String?,
      ip: json['ip'] as String?,
      bankCardList: (json['bankCardList'] as List<dynamic>?)
          ?.map(
              (cardJson) => BankCard.fromJson(cardJson as Map<String, dynamic>))
          .toList(),
      selectedEducationName: json['selectedEducationName'] as String?,
      selectedReligionName: json['selectedReligionName'] as String?,
      selectedGenderName: json['selectedGenderName'] as String?,
      selectedMaritalStatusName: json['selectedMaritalStatusName'] as String?,
      selectedReasonName: json['selectedReasonName'] as String?,
      selectedLivingArea: json['selectedLivingArea'] as String?,
      selectedPayDayName: json['selectedPayDayName'] as String?,
    );
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory PersonalInformationData.fromJsonString(String jsonString) {
    return PersonalInformationData.fromJson(jsonDecode(jsonString));
  }

  Map<String, dynamic> toApiRequest() {
    if (kDebugMode) {
      print(
          'PersonalInformationData.toApiRequest - birthday value: $birthday (type: ${birthday.runtimeType})');
      if (birthday != null && birthday != 0) {
        final date = DateTime.fromMillisecondsSinceEpoch(birthday! * 1000);
        print('PersonalInformationData.toApiRequest - birthday as date: $date');
      }
    }
    return {
      'idd': idd ?? 0,
      'phone': phone ?? '',
      'userName': userName?.trim() ?? '',
      'idCard': idCard ?? '',
      'idCardImage': idCardImage ?? '',
      'monthIncome': monthIncome ?? '',
      'education': education ?? 1,
      'religion': religion ?? 1,
      'childrenNum': childrenNum ?? 0,
      'faceVsKtpScore': faceVsKtpScore ?? 0.0,
      'birthday': birthday ?? 0,
      'sex': sex ?? 1,
      'facePhotoImage': facePhotoImage ?? '',
      'confidenceScore': confidenceScore ?? 0.0,
      'motherName': motherName ?? '',
      'maritalStatus': maritalStatus ?? 1,
      'province': province ?? 0,
      'city': city ?? 0,
      'districts': districts ?? 0,
      'subDistricts': subDistricts ?? 0,
      'provinceName': provinceName ?? '',
      'cityName': cityName ?? '',
      'provinceCode': provinceCode ?? 0,
      'cityCode': cityCode ?? 0,
      'detailAddress': detailAddress ?? '',
      'email': email ?? 'user@example.com',
      'whatsapp': whatsapp ?? '',
      'companyName': companyName ?? '',
      'workSeniority': workSeniority ?? 1,
      'workType': workType ?? 1,
      'workDetailAddress': workDetailAddress ?? '',
      'payDay': payDay ?? 1,
      'contactList': contactList
              ?.map((contact) => {
                    'name': contact.name,
                    'phone': contact.phoneNumber,
                    'contactType': 1, // Default contact type
                  })
              .toList() ??
          [],
      'deviceId': deviceId ?? '',
      'ip': ip ?? '',
      'bankCardList': bankCardList?.map((card) => card.toJson()).toList() ?? [],
    };
  }
}
