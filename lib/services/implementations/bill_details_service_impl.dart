import 'package:get_it/get_it.dart';
import 'package:padelgo/models/repayment_details.dart';
import 'package:padelgo/models/repayment_details_request.dart';
import 'package:padelgo/models/repayment_plan.dart';
import 'package:padelgo/repository/interfaces/bill_details_repository.dart';
import 'package:padelgo/services/interfaces/bill_details_service.dart';

class BillDetailsServiceImpl extends BillDetailsService {
  final _repository = GetIt.instance<BillDetailsRepository>();

  @override
  Future<RepaymentPlan?> postRepaymentPlan() {
    return _repository.postRepaymentPlan();
  }

  @override
  Future<RepaymentDetails?> getRepaymentDetails(
      RepaymentDetailsRequest request) {
    return _repository.getRepaymentDetails(request);
  }
}
