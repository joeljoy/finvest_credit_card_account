import 'package:collection/collection.dart';
import 'package:finvest_credit_card_account/common/finvest_data_helper.dart';
import 'package:finvest_credit_card_account/common/transactions/data/transaction_data_source.dart';
import 'package:finvest_credit_card_account/common/transactions/domain/entities/transaction.dart';
import 'package:finvest_credit_card_account/common/transactions/domain/transaction_repository.dart';
import 'package:get_it/get_it.dart';

class AppTransactionRepository implements TransactionRepository {
  final FinvestDataHelper _finvestDataHelper;

  AppTransactionRepository({required FinvestDataHelper finvestDataHelper})
      : _finvestDataHelper = finvestDataHelper;

  @override
  List<Transaction> getRecentTransactions(int limit) {
    return _finvestDataHelper.transactions
        .sorted((a, b) {
          return a.date.compareTo(b.date);
        })
        .take(limit)
        .toList(growable: false);
  }

  @override
  TransactionDataSource createDataSource() {
    return TransactionDataSource(finvestDataHelper: GetIt.instance.get());
  }
}
