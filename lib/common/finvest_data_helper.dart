import 'dart:math';

import 'package:finvest_credit_card_account/common/transactions/domain/entities/transaction.dart';

class FinvestDataHelper {
  List<String> merchantNames = [
    'Uber',
    'McDonalds',
    'Starbucks',
    'Ikea',
    'JBL Technologies'
  ];

  List<String> creditCards = [
    'City Gold',
    'WellsFargo Platinum',
  ];

  List<String> categoryIds = [
    'Food & Beverage',
    'Auto & Transport',
    'Health',
    'Entertainment',
    'Housing'
  ];

  /// Generates a list of random transactions.
  ///
  /// This function creates a specified number of transactions with randomized
  /// values for `merchantName`, `creditCardId`, `categoryId`, `status`,
  /// and `type`. The dates of the transactions are distributed to cover the
  /// following filters:
  /// - Current month
  /// - Last month
  /// - This year (excluding the current and last month)
  /// - Previous year
  ///
  /// The generated transactions include a good mix of `TransactionStatus` and
  /// `TransactionType`.
  List<Transaction> generateTransactions(int count) {
    final random = Random();
    final now = DateTime.now();
    final transactions = List<Transaction>.generate(count, (index) {
      final value = (random.nextDouble() * 10000).toStringAsFixed(2);
      TransactionStatus status = TransactionStatus
          .values[random.nextInt(TransactionStatus.values.length)];
      TransactionType type =
          TransactionType.values[random.nextInt(TransactionType.values.length)];
      String merchantName = merchantNames[random.nextInt(merchantNames.length)];
      String categoryId = categoryIds[random.nextInt(categoryIds.length)];
      String creditCardId = creditCards[random.nextInt(creditCards.length)];

      DateTime date;
      // 0: current month, 1: last month, 2: this year, 3: last year
      int filterCategory = random.nextInt(4);
      if (filterCategory == 0) {
        // Current month
        date = DateTime(now.year, now.month, random.nextInt(28) + 1);
      } else if (filterCategory == 1) {
        // Last month
        final lastMonth = DateTime(now.year, now.month - 1, 1);
        date =
            DateTime(lastMonth.year, lastMonth.month, random.nextInt(28) + 1);
      } else if (filterCategory == 2) {
        // This year
        date = DateTime(
          now.year,
          random.nextInt(now.month) + 1,
          random.nextInt(28) + 1,
        );
      } else {
        // Last year
        date = DateTime(
          now.year - 1,
          random.nextInt(12) + 1,
          random.nextInt(28) + 1,
        );
      }

      return Transaction(
        value: double.parse(value),
        date: date.millisecondsSinceEpoch,
        merchantName: merchantName,
        categoryId: categoryId,
        creditCardId: creditCardId,
        status: status,
        type: type,
      );
    });

    return transactions;
  }
}
