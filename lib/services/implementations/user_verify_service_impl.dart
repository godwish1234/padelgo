import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:padelgo/models/area.dart';
import 'package:padelgo/models/bank_list_response.dart';
import 'package:padelgo/models/contact_validation_response.dart';
import 'package:padelgo/models/emergency_contact.dart';
import 'package:padelgo/repository/interfaces/user_verify_repository.dart';
import 'package:padelgo/services/interfaces/user_verify_service.dart';

class UserVerifyServiceImpl implements UserVerifyService {
  final UserVerifyRepository _repository =
      GetIt.instance<UserVerifyRepository>();

  static final Map<String, AreasEntity> _areasCache = <String, AreasEntity>{};
  static BankListResponse? _bankListCache;

  @override
  Future<AreasEntity?> getAreas(String pid) async {
    if (_areasCache.containsKey(pid)) {
      final cachedResult = _areasCache[pid]!;
      return cachedResult;
    }

    try {
      final areasEntity = await _repository.getAreas(pid);

      if (areasEntity != null && areasEntity.isSuccess) {
        _areasCache[pid] = areasEntity;
      }
      return areasEntity;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting areas: $e');
      }
      return null;
    }
  }

  static void _clearAreasCache() {
    _areasCache.clear();
  }

  @override
  void clearAreasCache() {
    UserVerifyServiceImpl._clearAreasCache();
  }

  @override
  Future<BankListResponse?> getBankList({int? appId, int? type}) async {
    if (appId == null && type == null && _bankListCache != null) {
      return _bankListCache;
    }

    try {
      final bankListResponse =
          await _repository.getBankList(appId: appId, type: type);

      if (bankListResponse != null && appId == null && type == null) {
        _bankListCache = bankListResponse;
      }

      return bankListResponse;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting bank list: $e');
      }
      return null;
    }
  }

  @override
  Future<bool> submitUserInfo(Map<String, dynamic> personalData) async {
    return await _repository.submitUserInfo(personalData);
  }

  @override
  Future<bool> userBindBank(Map<String, dynamic> bankData) async {
    return await _repository.userBindBank(bankData);
  }

  @override
  Future<ContactValidationResponse?> validateContacts(
      List<EmergencyContact> contacts,
      String? Function(String relationship) getContactTypeId) async {
    try {
      return await _repository.validateContacts(contacts, getContactTypeId);
    } catch (e) {
      if (kDebugMode) {
        print('Error validating contacts: $e');
      }
      return null;
    }
  }
}
