import 'package:padelgo/models/area.dart';
import 'package:padelgo/models/bank_list_response.dart';
import 'package:padelgo/models/contact_validation_response.dart';
import 'package:padelgo/models/emergency_contact.dart';

abstract class UserVerifyService {
  Future<AreasEntity?> getAreas(String pid);
  Future<BankListResponse?> getBankList({int? appId, int? type});
  Future<bool> submitUserInfo(Map<String, dynamic> personalData);
  Future<bool> userBindBank(Map<String, dynamic> bankData);
  Future<ContactValidationResponse?> validateContacts(
      List<EmergencyContact> contacts,
      String? Function(String relationship) getContactTypeId);
  void clearAreasCache();
}
