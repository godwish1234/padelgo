class EmergencyContact {
  final String name;
  final String phoneNumber;
  final String relationship;

  EmergencyContact({
    required this.name,
    required this.phoneNumber,
    required this.relationship,
  });

  bool get isValid {
    return name.trim().isNotEmpty &&
        phoneNumber.trim().isNotEmpty &&
        relationship.trim().isNotEmpty &&
        _isPhoneNumberValid(phoneNumber);
  }

  bool _isPhoneNumberValid(String phone) {
    if (phone.trim().isEmpty) return false;

    final phoneNum = phone.trim();

    if (phoneNum.length < 10 || phoneNum.length > 13) return false;

    if (!phoneNum.startsWith('0') && !phoneNum.startsWith('8')) return false;

    if (!RegExp(r'^\d+$').hasMatch(phoneNum)) return false;

    return true;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'relationship': relationship,
    };
  }

  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      relationship: json['relationship'] ?? '',
    );
  }

  EmergencyContact copyWith({
    String? name,
    String? phoneNumber,
    String? relationship,
  }) {
    return EmergencyContact(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      relationship: relationship ?? this.relationship,
    );
  }
}
