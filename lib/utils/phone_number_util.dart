class PhoneNumberUtil {
  static String normalizeIndonesianPhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) return phoneNumber;

    String cleaned = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    if (cleaned.startsWith('62')) {
      cleaned = cleaned.substring(2);
    }

    cleaned = cleaned.replaceFirst(RegExp(r'^0+'), '');

    if (!cleaned.startsWith('8')) {
      return cleaned;
    }

    if (cleaned.length < 9 || cleaned.length > 12) {
      return cleaned;
    }

    return cleaned;
  }

  static bool isValidIndonesianPhoneNumber(String normalizedPhoneNumber) {
    if (normalizedPhoneNumber.isEmpty) return false;

    if (!RegExp(r'^\d+$').hasMatch(normalizedPhoneNumber)) return false;

    if (!normalizedPhoneNumber.startsWith('8')) return false;

    if (normalizedPhoneNumber.length < 9 || normalizedPhoneNumber.length > 12) {
      return false;
    }

    return true;
  }

  static String formatForDisplay(String phoneNumber) {
    String normalized = normalizeIndonesianPhoneNumber(phoneNumber);
    if (normalized.isEmpty) return phoneNumber;

    return '+62 $normalized';
  }

  static String? validateAndNormalize(String phoneNumber) {
    String normalized = normalizeIndonesianPhoneNumber(phoneNumber);

    if (isValidIndonesianPhoneNumber(normalized)) {
      return normalized;
    }

    return null;
  }
}
