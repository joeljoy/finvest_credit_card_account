import 'package:finvest_credit_card_account/common/transactions/data/transaction_data_source.dart';
import 'package:finvest_credit_card_account/common/transactions/domain/entities/transaction.dart';

abstract class TransactionRepository {
  List<Transaction> getRecentTransactions(int limit);
  TransactionDataSource createDataSource();
}
