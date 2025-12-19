import 'package:padelgo/models/delete_bank.dart';
import 'package:padelgo/models/delete_bank_request.dart';
import 'package:padelgo/models/user_bank.dart';
import 'package:padelgo/models/user_bind_bank.dart';
import 'package:padelgo/models/user_bind_bank_request.dart';

abstract class BankAccountRepository {
  Future<UserBank?> postUserBank();
  Future<UserBindBank?> postUserBindBank(UserBindBankRequest userBindBank);
  Future<DeleteBank?> deleteBank(DeleteBankRequest request);
}
