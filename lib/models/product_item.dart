import 'package:json_annotation/json_annotation.dart';

part 'product_item.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductItem {
  int? id;
  int? appId;
  String? partnerLogo;
  String? partnerName;
  String? partnerDescription;
  String? partnerPhone;
  String? partnerApi;
  int? type;
  String? secretKey;
  int? defaultAmount;
  int? defaultLoanDays;
  double? defaultInterestRate;
  String? extend;
  String? iosDownloadUrl;
  String? androidDownloadUrl;
  String? admittanceUrl;
  String? credentialStuffingUrl;
  String? pushUserDataUrl;
  String? creditDataUrl;
  String? loanProductUrl;
  String? loanContractUrl;
  String? submitLoanUrl;
  String? loanPreviewUrl;
  String? bankListUrl;
  String? bindBankUrl;
  String? setDefaultBankUrl;
  String? preBind;
  String? getBank;
  String? userLoanAmt;
  String? orderStatusUrl;
  String? repayPlanUrl;
  String? repayDetailsUrl;
  String? contractSignUrl;
  String? queryUserUrl;
  int? status;
  int? isHead;
  int? addBank;
  int? isSign;
  int? isReload;
  int? created;
  int? updated;
  String? businessType;

  ProductItem({
    this.id,
    this.appId,
    this.partnerLogo,
    this.partnerName,
    this.partnerDescription,
    this.partnerPhone,
    this.partnerApi,
    this.type,
    this.secretKey,
    this.defaultAmount,
    this.defaultLoanDays,
    this.defaultInterestRate,
    this.extend,
    this.iosDownloadUrl,
    this.androidDownloadUrl,
    this.admittanceUrl,
    this.credentialStuffingUrl,
    this.pushUserDataUrl,
    this.creditDataUrl,
    this.loanProductUrl,
    this.loanContractUrl,
    this.submitLoanUrl,
    this.loanPreviewUrl,
    this.bankListUrl,
    this.bindBankUrl,
    this.setDefaultBankUrl,
    this.preBind,
    this.getBank,
    this.userLoanAmt,
    this.orderStatusUrl,
    this.repayPlanUrl,
    this.repayDetailsUrl,
    this.contractSignUrl,
    this.queryUserUrl,
    this.status,
    this.isHead,
    this.addBank,
    this.isSign,
    this.isReload,
    this.created,
    this.updated,
    this.businessType,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) =>
      _$ProductItemFromJson(json);

  Map<String, dynamic> toJson() => _$ProductItemToJson(this);
}
