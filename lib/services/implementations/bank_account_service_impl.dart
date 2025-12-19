import 'package:get_it/get_it.dart';
import 'package:padelgo/models/delete_bank.dart';
import 'package:padelgo/models/delete_bank_request.dart';
import 'package:padelgo/models/user_bank.dart';
import 'package:padelgo/models/user_bind_bank.dart';
import 'package:padelgo/models/user_bind_bank_request.dart';
import 'package:padelgo/repository/interfaces/bank_account_repository.dart';
import 'package:padelgo/services/interfaces/bank_account_service.dart';

class BankAccountServiceImpl extends BankAccountService {
  final _repository = GetIt.instance<BankAccountRepository>();

  @override
  Future<UserBank?> postUserBank() {
    return _repository.postUserBank();
  }

  @override
  Future<UserBindBank?> postUserBindBank(UserBindBankRequest userBindBank) {
    return _repository.postUserBindBank(userBindBank);
  }

  @override
  Future<DeleteBank?> deleteBank(DeleteBankRequest request) {
    return _repository.deleteBank(request);
  }
}
