// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_products_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoanProductsResponse _$LoanProductsResponseFromJson(
        Map<String, dynamic> json) =>
    LoanProductsResponse(
      userId: (json['userId'] as num?)?.toInt(),
      phone: json['phone'] as String?,
      partnerProductList: (json['partnerProductList'] as List<dynamic>?)
          ?.map((e) => PartnerProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      successCount: (json['successCount'] as num?)?.toInt(),
      failedCount: (json['failedCount'] as num?)?.toInt(),
      totalProductCount: (json['totalProductCount'] as num?)?.toInt(),
    )
      ..msg = json['msg'] as String?
      ..code = json['code'] as String?
      ..traceId = json['traceId'] as String?
      ..timestamp = json['timestamp'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$LoanProductsResponseToJson(
        LoanProductsResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'traceId': instance.traceId,
      'timestamp': instance.timestamp,
      'success': instance.success,
      'userId': instance.userId,
      'phone': instance.phone,
      'partnerProductList':
          instance.partnerProductList?.map((e) => e.toJson()).toList(),
      'successCount': instance.successCount,
      'failedCount': instance.failedCount,
      'totalProductCount': instance.totalProductCount,
    };

PartnerProduct _$PartnerProductFromJson(Map<String, dynamic> json) =>
    PartnerProduct(
      appId: (json['appId'] as num?)?.toInt(),
      partnerName: json['partnerName'] as String?,
      partnerLogo: json['partnerLogo'] as String?,
      partnerDescription: json['partnerDescription'] as String?,
      partnerPhone: json['partnerPhone'] as String?,
      partnerApi: json['partnerApi'] as String?,
      defaultAmount: (json['defaultAmount'] as num?)?.toInt(),
      defaultLoanDays: (json['defaultLoanDays'] as num?)?.toInt(),
      defaultInterestRate: (json['defaultInterestRate'] as num?)?.toDouble(),
      iosDownloadUrl: json['iosDownloadUrl'] as String?,
      androidDownloadUrl: json['androidDownloadUrl'] as String?,
      status: (json['status'] as num?)?.toInt(),
      isHead: (json['isHead'] as num?)?.toInt(),
      querySuccess: json['querySuccess'] as bool?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ProductDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      productCount: (json['productCount'] as num?)?.toInt(),
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$PartnerProductToJson(PartnerProduct instance) =>
    <String, dynamic>{
      'appId': instance.appId,
      'partnerName': instance.partnerName,
      'partnerLogo': instance.partnerLogo,
      'partnerDescription': instance.partnerDescription,
      'partnerPhone': instance.partnerPhone,
      'partnerApi': instance.partnerApi,
      'defaultAmount': instance.defaultAmount,
      'defaultLoanDays': instance.defaultLoanDays,
      'defaultInterestRate': instance.defaultInterestRate,
      'iosDownloadUrl': instance.iosDownloadUrl,
      'androidDownloadUrl': instance.androidDownloadUrl,
      'status': instance.status,
      'isHead': instance.isHead,
      'querySuccess': instance.querySuccess,
      'products': instance.products?.map((e) => e.toJson()).toList(),
      'productCount': instance.productCount,
      'errorMessage': instance.errorMessage,
    };

ProductDetail _$ProductDetailFromJson(Map<String, dynamic> json) =>
    ProductDetail(
      productId: (json['productId'] as num?)?.toInt(),
      limitAmount: json['limitAmount'] as String?,
      minAmount: json['minAmount'] as String?,
      loanTerm: (json['loanTerm'] as num?)?.toInt(),
      loanTermUnit: (json['loanTermUnit'] as num?)?.toInt(),
      loanPeriod: (json['loanPeriod'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$ProductDetailToJson(ProductDetail instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'limitAmount': instance.limitAmount,
      'minAmount': instance.minAmount,
      'loanTerm': instance.loanTerm,
      'loanTermUnit': instance.loanTermUnit,
      'loanPeriod': instance.loanPeriod,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
