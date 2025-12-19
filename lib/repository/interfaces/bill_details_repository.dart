import 'package:padelgo/models/repayment_details.dart';
import 'package:padelgo/models/repayment_details_request.dart';
import 'package:padelgo/models/repayment_plan.dart';

abstract class BillDetailsRepository {
  Future<RepaymentPlan?> postRepaymentPlan();
  Future<RepaymentDetails?> getRepaymentDetails(
      RepaymentDetailsRequest request);
}
