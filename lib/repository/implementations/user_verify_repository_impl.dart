import 'package:flutter/foundation.dart';
import 'package:padelgo/constants/end_point.dart';
import 'package:padelgo/models/area.dart';
import 'package:padelgo/models/bank_list_response.dart';
import 'package:padelgo/models/contact_validation_response.dart';
import 'package:padelgo/models/emergency_contact.dart';
import 'package:padelgo/repository/base/helpers.dart';
import 'package:padelgo/repository/base/rest_api_repository_base.dart';
import 'package:padelgo/repository/interfaces/user_verify_repository.dart';

class UserVerifyRepositoryImpl extends RestApiRepositoryBase
    implements UserVerifyRepository {
  @override
  Future<AreasEntity?> getAreas(String pid) async {
    try {
      return await GetHelper<AreasEntity>().getCommon(() async {
        return await get(EndPoint.getAreas, body: {'pid': pid});
      }, (responseData) {
        return AreasEntity.fromJson(responseData);
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to fetch areas: $e');
      }
      rethrow;
    }
  }

  @override
  Future<ContactValidationResponse?> validateContacts(
      List<EmergencyContact> contacts,
      String? Function(String relationship) getContactTypeId) async {
    try {
      final contactList = contacts.map((contact) {
        final contactTypeId = getContactTypeId(contact.relationship);

        int contactType = 1;
        if (contactTypeId != null) {
          contactType = int.tryParse(contactTypeId) ?? 1;
        }

        if (kDebugMode) {
          print(
              'Contact: ${contact.name}, Relationship: "${contact.relationship}", ContactType: $contactType');
        }

        return {
          'name': contact.name,
          'phone': contact.phoneNumber,
          'contactType': contactType,
        };
      }).toList();

      final requestBody = {
        'contactList': contactList,
      };

      if (kDebugMode) {
        print('Validating contacts with request body: $requestBody');
      }

      return await GetHelper<ContactValidationResponse>().getCommon(() async {
        return await post(EndPoint.validateContacts, requestBody);
      }, (responseData) {
        return ContactValidationResponse.fromJson(responseData);
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to validate contacts: $e');
      }
      rethrow;
    }
  }

  @override
  Future<BankListResponse?> getBankList({int? appId, int? type}) async {
    try {
      return await GetHelper<BankListResponse>().getCommon(() async {
        Map<String, dynamic>? body;
        if (appId != null || type != null) {
          body = <String, dynamic>{};
          if (appId != null) body['appId'] = appId;
          if (type != null) body['type'] = type;
        }

        return await get(EndPoint.getBankList, body: body);
      }, (responseData) {
        return BankListResponse.fromJson(responseData);
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to fetch bank list: $e');
      }
      rethrow;
    }
  }

  @override
  Future<bool> submitUserInfo(Map<String, dynamic> personalData) async {
    try {
      if (kDebugMode) {
        debugPrint(personalData.toString(), wrapWidth: 1024);
      }
      final response =
          await GetHelper<Map<String, dynamic>>().getCommon(() async {
        return await post(EndPoint.uploadUserInfo, personalData);
      }, (responseData) {
        return responseData;
      });

      return response != null && response['success'] == true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to submit personal info: $e');
      }
      return false;
    }
  }

  @override
  Future<bool> userBindBank(Map<String, dynamic> bankData) async {
    try {
      final response =
          await GetHelper<Map<String, dynamic>>().getCommon(() async {
        return await post(EndPoint.bindBank, bankData);
      }, (responseData) {
        return responseData;
      });

      return response != null && response['success'] == true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to bind bank: $e');
      }
      return false;
    }
  }
}
