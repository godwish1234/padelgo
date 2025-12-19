class BankCard {
  final String? bankName;
  final String? cardNum;
  final String? bankCode;

  BankCard({
    this.bankName,
    this.cardNum,
    this.bankCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'bankName': bankName ?? '',
      'cardNum': cardNum ?? '',
      'bankCode': bankCode ?? '',
    };
  }

  factory BankCard.fromJson(Map<String, dynamic> json) {
    return BankCard(
      bankName: json['bankName'] as String?,
      cardNum: json['cardNum'] as String?,
      bankCode: json['bankCode'] as String?,
    );
  }

  BankCard copyWith({
    String? bankName,
    String? cardNum,
    String? bankCode,
  }) {
    return BankCard(
      bankName: bankName ?? this.bankName,
      cardNum: cardNum ?? this.cardNum,
      bankCode: bankCode ?? this.bankCode,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BankCard &&
        other.bankName == bankName &&
        other.cardNum == cardNum &&
        other.bankCode == bankCode;
  }

  @override
  int get hashCode {
    return bankName.hashCode ^ cardNum.hashCode ^ bankCode.hashCode;
  }

  @override
  String toString() {
    return 'BankCard(bankName: $bankName, cardNum: $cardNum, bankCode: $bankCode)';
  }
}
