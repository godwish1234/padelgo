import 'package:flutter/foundation.dart';
import 'package:padelgo/services/interfaces/phone_number_service.dart';
import 'package:sms_autofill/sms_autofill.dart';

class PhoneNumberServiceImpl implements PhoneNumberService {
  @override
  Future<List<String>> getGooglePhoneNumbers() async {
    try {
      String? phoneNumber = await SmsAutoFill().hint;

      List<String> phoneNumbers = [];

      if (phoneNumber != null && phoneNumber.isNotEmpty) {
        String formattedNumber = _formatPhoneNumber(phoneNumber);
        phoneNumbers.add(formattedNumber);

        if (kDebugMode) {
          print('Phone number hint received: $formattedNumber');
        }
      } else {
        if (kDebugMode) {
          print('No phone number hint available');
        }
      }

      return phoneNumbers;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting phone number hint: $e');
      }
      return [];
    }
  }

  String _formatPhoneNumber(String phoneNumber) {
    String cleaned = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

    if (!cleaned.startsWith('+')) {
      if (cleaned.startsWith('0')) {
        cleaned = cleaned.substring(1);
      }
      cleaned = '+62$cleaned';
    }

    if (cleaned.startsWith('+62')) {
      String numberPart = cleaned.substring(3);
      return '+62 $numberPart';
    }

    return cleaned;
  }
}
