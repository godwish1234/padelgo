import 'package:flutter/foundation.dart';
import 'package:padelgo/constants/end_point.dart';
import 'package:padelgo/models/repayment_details.dart';
import 'package:padelgo/models/repayment_details_request.dart';
import 'package:padelgo/models/repayment_plan.dart';
import 'package:padelgo/repository/base/helpers.dart';
import 'package:padelgo/repository/base/rest_api_repository_base.dart';
import 'package:padelgo/repository/interfaces/bill_details_repository.dart';

class BillDetailsRepositoryImpl extends RestApiRepositoryBase
    implements BillDetailsRepository {
  @override
  Future<RepaymentPlan?> postRepaymentPlan() async {
    try {
      return await GetHelper<RepaymentPlan>().getCommon(() async {
        return await post(EndPoint.repaymentPlan, {});
      }, (responseData) {
        return RepaymentPlan.fromJson(responseData);
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to fetch products: $e');
      }
      rethrow;
    }
  }

  @override
  Future<RepaymentDetails?> getRepaymentDetails(
      RepaymentDetailsRequest request) async {
    try {
      return await GetHelper<RepaymentDetails>().getCommon(() async {
        return await get(EndPoint.repaymentDetails, body: request.toJson());
      }, (responseData) {
        return RepaymentDetails.fromJson(responseData);
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to fetch products: $e');
      }
      rethrow;
    }
  }
}
