import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:padelgo/models/bank_bind_status.dart';
import 'package:padelgo/models/default_bank.dart';
import 'package:padelgo/models/loan_contract.dart';
import 'package:padelgo/models/loan_preview.dart';
import 'package:padelgo/models/upload_info_status.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:padelgo/constants/end_point.dart';
import 'package:padelgo/models/credit_status.dart';
import 'package:padelgo/models/enumerations_response.dart';
import 'package:padelgo/models/product_item.dart';
import 'package:padelgo/models/loan_products_response.dart';
import 'package:padelgo/repository/base/helpers.dart';
import 'package:padelgo/repository/base/rest_api_repository_base.dart';
import 'package:padelgo/repository/interfaces/home_repository.dart';

class HomeRepositoryImpl extends RestApiRepositoryBase
    implements HomeRepository {
  @override
  Future<List<ProductItem>?> getHomeProducts() async {
    try {
      return await GetHelper<ProductItem>().getListCommon(() async {
        return await get(EndPoint.homePartner);
      }, ProductItem.fromJson);
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to fetch home products: $e');
      }
      rethrow;
    }
  }

  @override
  Future<UploadInfoStatus?> getUploadInfoStatus() async {
    try {
      return await GetHelper<UploadInfoStatus>().getCommon(() async {
        return await get(EndPoint.uploadStatus);
      }, (responseData) {
        return UploadInfoStatus.fromJson(responseData);
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to fetch upload info status: $e');
      }
      rethrow;
    }
  }

  @override
  Future<BankBindStatus?> getBankBindStatus() async {
    try {
      return await GetHelper<BankBindStatus>().getCommon(() async {
        return await get(EndPoint.bankBindStatus);
      }, (responseData) {
        return BankBindStatus.fromJson(responseData);
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to fetch bank bind status: $e');
      }
      rethrow;
    }
  }

  @override
  Future<CreditStatus?> getCreditStatus() async {
    try {
      return await GetHelper<CreditStatus>().getCommon(() async {
        return await post(EndPoint.creditStatus, {});
      }, (responseData) {
        return CreditStatus.fromJson(responseData);
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to fetch credit status: $e');
      }
      rethrow;
    }
  }

  @override
  Future<EnumerationsResponse?> getEnums() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedEnums = prefs.getString('cached_enums');

      if (cachedEnums != null) {
        try {
          final Map<String, dynamic> jsonData = jsonDecode(cachedEnums);
          if (kDebugMode) {
            print('Returning cached enumerations');
          }
          return EnumerationsResponse.fromJson(jsonData);
        } catch (e) {
          if (kDebugMode) {
            print('Error parsing cached enums, fetching from API: $e');
          }
        }
      }

      final result =
          await GetHelper<EnumerationsResponse>().getCommon(() async {
        return await get(EndPoint.getEnums);
      }, (responseData) {
        return EnumerationsResponse.fromJson(responseData);
      });

      if (result != null) {
        try {
          final jsonString = jsonEncode(result.toJson());
          await prefs.setString('cached_enums', jsonString);
          if (kDebugMode) {
            print('Enumerations cached successfully');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Error caching enumerations: $e');
          }
        }
      }

      return result;
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to fetch enumerations: $e');
      }
      rethrow;
    }
  }

  @override
  Future<LoanProductsResponse?> getLoanProducts() async {
    try {
      return await GetHelper<LoanProductsResponse>().getCommon(() async {
        return await get(EndPoint.searchLoanProducts);
      }, (responseData) {
        return LoanProductsResponse.fromJson(responseData);
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to fetch loan products: $e');
      }
      rethrow;
    }
  }

  @override
  Future<LoanPreview?> previewLoan(Map<String, dynamic> data) async {
    try {
      return await GetHelper<LoanPreview>().getCommon(() async {
        return await post(EndPoint.previewLoan, data);
      }, (responseData) {
        return LoanPreview.fromJson(responseData);
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to preview loan: $e');
      }
      rethrow;
    }
  }

  @override
  Future<LoanContract?> loanContract(Map<String, dynamic> data) async {
    try {
      return await GetHelper<LoanContract>().getCommon(() async {
        return await post(EndPoint.getLoanContract, data);
      }, (responseData) {
        return LoanContract.fromJson(responseData);
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to loan contract: $e');
      }
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>?> submitLoan(Map<String, dynamic> data) async {
    try {
      final response = await post(EndPoint.submit, data);
      if (response != null) {
        return {
          'success': response['success'] == true,
          'msg': response['msg'] as String? ?? 'Unknown error occurred'
        };
      }
      return {'success': false, 'msg': 'Unknown error occurred'};
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to submit loan: $e');
      }
      rethrow;
    }
  }

  @override
  Future<DefaultBank?> defaultBank(Map<String, dynamic> data) async {
    try {
      return await GetHelper<DefaultBank>().getCommon(() async {
        return await get(EndPoint.defaultBank, body: data);
      }, (responseData) {
        return DefaultBank.fromJson(responseData);
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to submit loan: $e');
      }
      rethrow;
    }
  }

  @override
  Future<bool> updateRating(int ratingLevel) async {
    try {
      final response = await post(EndPoint.updateRating, {
        'ratingLevel': ratingLevel,
      });

      if (kDebugMode) {
        print('Rating updated with level: $ratingLevel');
      }

      return response != null && response['success'] == true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to update rating: $e');
      }
      rethrow;
    }
  }
}
