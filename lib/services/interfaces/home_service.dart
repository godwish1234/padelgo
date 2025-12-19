import 'package:padelgo/models/bank_bind_status.dart';
import 'package:padelgo/models/credit_status.dart';
import 'package:padelgo/models/default_bank.dart';
import 'package:padelgo/models/enumerations_response.dart';
import 'package:padelgo/models/loan_contract.dart';
import 'package:padelgo/models/loan_preview.dart';
import 'package:padelgo/models/loan_products_response.dart';
import 'package:padelgo/models/product_item.dart';
import 'package:padelgo/models/upload_info_status.dart';

abstract class HomeService<T> {
  Future<List<ProductItem>?> getHomeProducts();
  Future<UploadInfoStatus?> getUploadInfoStatus();
  Future<BankBindStatus?> getBankBindStatus();
  Future<CreditStatus?> getCreditStatus();
  Future<EnumerationsResponse?> getEnums();
  Future<LoanProductsResponse?> getLoanProducts();
  Future<LoanPreview?> previewLoan(Map<String, dynamic> data);
  Future<LoanContract?> loanContract(Map<String, dynamic> data);
  Future<Map<String, dynamic>?> submitLoan(Map<String, dynamic> data);
  Future<DefaultBank?> defaultBank(Map<String, dynamic> data);
}
