import 'package:flutter/foundation.dart';
import 'package:padelgo/constants/end_point.dart';
import 'package:padelgo/models/delete_bank.dart';
import 'package:padelgo/models/delete_bank_request.dart';
import 'package:padelgo/models/user_bank.dart';
import 'package:padelgo/models/user_bind_bank.dart';
import 'package:padelgo/models/user_bind_bank_request.dart';
import 'package:padelgo/repository/base/helpers.dart';
import 'package:padelgo/repository/base/rest_api_repository_base.dart';
import 'package:padelgo/repository/interfaces/bank_account_repository.dart';

class BankAccountRepositoryImpl extends RestApiRepositoryBase
    implements BankAccountRepository {
  @override
  Future<UserBank?> postUserBank() async {
    try {
      return await GetHelper<UserBank>().getCommon(() async {
        return await post(EndPoint.userBank, {});
      }, (responseData) {
        return UserBank.fromJson(responseData);
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to fetch products: $e');
      }
      rethrow;
    }
  }

  @override
  Future<UserBindBank?> postUserBindBank(
      UserBindBankRequest userBindBank) async {
    try {
      return await GetHelper<UserBindBank>().getCommon(() async {
        return await post(EndPoint.bindBank, userBindBank.toJson());
      }, (responseData) {
        return UserBindBank.fromJson(responseData);
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to fetch products: $e');
      }
      rethrow;
    }
  }

  @override
  Future<DeleteBank?> deleteBank(DeleteBankRequest request) async {
    try {
      return await GetHelper<DeleteBank>().getCommon(() async {
        return await post(EndPoint.deleteBank, request.toJson());
      }, (responseData) {
        return DeleteBank.fromJson(responseData);
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to fetch products: $e');
      }
      rethrow;
    }
  }
}
