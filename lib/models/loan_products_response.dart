import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';

part 'loan_products_response.g.dart';

@JsonSerializable(explicitToJson: true)
class LoanProductsResponse with BaseProtocolMixin {
  int? userId;
  String? phone;
  @JsonKey(name: 'partnerProductList')
  List<PartnerProduct>? partnerProductList;
  int? successCount;
  int? failedCount;
  int? totalProductCount;

  LoanProductsResponse({
    this.userId,
    this.phone,
    this.partnerProductList,
    this.successCount,
    this.failedCount,
    this.totalProductCount,
  });

  factory LoanProductsResponse.fromJson(Map<String, dynamic> json) {
    final response = _$LoanProductsResponseFromJson(json);
    response.parseBaseProtocol(json);
    return response;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$LoanProductsResponseToJson(this);
    data.addAll(getBaseProtocolJson());
    return data;
  }

  // Helper methods
  List<PartnerProduct> get activePartners =>
      partnerProductList?.where((partner) => partner.isActive).toList() ?? [];

  List<PartnerProduct> get headPartners =>
      partnerProductList?.where((partner) => partner.isHeadPartner).toList() ??
      [];
}

@JsonSerializable(explicitToJson: true)
class PartnerProduct {
  int? appId;
  String? partnerName;
  String? partnerLogo;
  String? partnerDescription;
  String? partnerPhone;
  String? partnerApi;
  int? defaultAmount;
  int? defaultLoanDays;
  double? defaultInterestRate;
  String? iosDownloadUrl;
  String? androidDownloadUrl;
  int? status;
  int? isHead;
  bool? querySuccess;
  List<ProductDetail>? products;
  int? productCount;
  String? errorMessage;

  PartnerProduct({
    this.appId,
    this.partnerName,
    this.partnerLogo,
    this.partnerDescription,
    this.partnerPhone,
    this.partnerApi,
    this.defaultAmount,
    this.defaultLoanDays,
    this.defaultInterestRate,
    this.iosDownloadUrl,
    this.androidDownloadUrl,
    this.status,
    this.isHead,
    this.querySuccess,
    this.products,
    this.productCount,
    this.errorMessage,
  });

  factory PartnerProduct.fromJson(Map<String, dynamic> json) =>
      _$PartnerProductFromJson(json);

  Map<String, dynamic> toJson() => _$PartnerProductToJson(this);

  // Helper methods
  String get formattedDefaultAmount {
    return (defaultAmount ?? 0).toString();
  }

  String get formattedInterestRate {
    return '${((defaultInterestRate ?? 0) * 100).toStringAsFixed(2)}%';
  }

  double get dailyInterestRate {
    return defaultInterestRate ?? 0.0;
  }

  bool get isActive => status == 1;
  bool get isHeadPartner => isHead == 1;
}

@JsonSerializable(explicitToJson: true)
class ProductDetail {
  int? productId;
  String? limitAmount;
  String? minAmount;
  int? loanTerm;
  int? loanTermUnit;
  int? loanPeriod;
  String? createdAt;
  String? updatedAt;

  ProductDetail({
    this.productId,
    this.limitAmount,
    this.minAmount,
    this.loanTerm,
    this.loanTermUnit,
    this.loanPeriod,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailToJson(this);

  // Helper methods
  int get limitAmountAsInt => int.tryParse(limitAmount ?? '') ?? 0;
  int get minAmountAsInt => int.tryParse(minAmount ?? '') ?? 0;
}
