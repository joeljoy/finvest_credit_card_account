import 'package:finvest_credit_card_account/common/transactions/domain/entities/transaction.dart';

abstract class TransactionRepository {
  List<Transaction> getRecentTransactions(int limit);
}
