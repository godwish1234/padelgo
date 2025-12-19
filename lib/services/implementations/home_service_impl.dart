import 'package:get_it/get_it.dart';
import 'package:padelgo/models/bank_bind_status.dart';
import 'package:padelgo/models/credit_status.dart';
import 'package:padelgo/models/default_bank.dart';
import 'package:padelgo/models/enumerations_response.dart';
import 'package:padelgo/models/loan_contract.dart';
import 'package:padelgo/models/loan_preview.dart';
import 'package:padelgo/models/loan_products_response.dart';
import 'package:padelgo/models/product_item.dart';
import 'package:padelgo/models/upload_info_status.dart';
import 'package:padelgo/repository/interfaces/home_repository.dart';
import 'package:padelgo/services/interfaces/home_service.dart';

class HomeServiceImpl implements HomeService {
  final _homeRepository = GetIt.instance<HomeRepository>();

  @override
  Future<List<ProductItem>?> getHomeProducts() async {
    return _homeRepository.getHomeProducts();
  }

  @override
  Future<UploadInfoStatus?> getUploadInfoStatus() async {
    return _homeRepository.getUploadInfoStatus();
  }

  @override
  Future<BankBindStatus?> getBankBindStatus() async {
    return _homeRepository.getBankBindStatus();
  }

  @override
  Future<CreditStatus?> getCreditStatus() async {
    return _homeRepository.getCreditStatus();
  }

  @override
  Future<EnumerationsResponse?> getEnums() async {
    return _homeRepository.getEnums();
  }

  @override
  Future<LoanProductsResponse?> getLoanProducts() async {
    return _homeRepository.getLoanProducts();
  }

  @override
  Future<LoanPreview?> previewLoan(Map<String, dynamic> data) async {
    return _homeRepository.previewLoan(data);
  }

  @override
  Future<LoanContract?> loanContract(Map<String, dynamic> data) async {
    return _homeRepository.loanContract(data);
  }

  @override
  Future<Map<String, dynamic>?> submitLoan(Map<String, dynamic> data) async {
    return _homeRepository.submitLoan(data);
  }

  @override
  Future<DefaultBank?> defaultBank(Map<String, dynamic> data) async {
    return _homeRepository.defaultBank(data);
  }
}
