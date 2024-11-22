import 'dart:math';

import 'package:finvest_credit_card_account/common/credit_card/domain/entities/credit_card.dart';
import 'package:finvest_credit_card_account/common/finvest_data_helper.dart';

class CreditCardDataSource {
  final FinvestDataHelper _finvestDataHelper;

  CreditCardDataSource({required FinvestDataHelper finvestDataHelper})
      : _finvestDataHelper = finvestDataHelper;

  List<String> get cardNames => _finvestDataHelper.creditCards;

  List<CreditCard> getCreditCardList() {
    final random = Random();
    return _finvestDataHelper.creditCards.map((cardId) {
      final maskedNumber =
          '**** **** **** ${random.nextInt(10000).toString().padLeft(4, '0')}';
      return CreditCard(id: cardId, maskedNumber: maskedNumber, name: cardId);
    }).toList(growable: false);
  }

  Map<String, double> calculateCreditCardBalances() {
    final transactions = _finvestDataHelper.transactions;
    final Map<String, double> creditCardBalances = {};

    for (var transaction in transactions) {
      creditCardBalances.update(
        transaction.creditCardId,
        (currentBalance) => currentBalance + transaction.value,
        ifAbsent: () => transaction.value,
      );
    }

    return creditCardBalances;
  }

  Map<String, double> calculateCreditCardBalancesFor({
    required DateTime start,
    required DateTime end,
  }) {
    final transactions = _finvestDataHelper.transactions.where((transaction) {
      final startTimeInMilliSeconds = start.millisecondsSinceEpoch;
      final endTimeInMilliSeconds = end.millisecondsSinceEpoch;
      return transaction.date >= startTimeInMilliSeconds &&
          transaction.date <= endTimeInMilliSeconds;
    });
    final Map<String, double> creditCardBalances = {};

    for (var transaction in transactions) {
      creditCardBalances.update(
        transaction.creditCardId,
        (currentBalance) => currentBalance + transaction.value,
        ifAbsent: () => transaction.value,
      );
    }

    return creditCardBalances;
  }

  double calculateTotalBalance() {
    final creditCardToBalanceMap = calculateCreditCardBalances();
    return creditCardToBalanceMap.values.fold(0.0, (sum, value) => sum + value);
  }

  double calculateTotalBalanceForPeriod(
      {required DateTime start, required DateTime end}) {
    final creditCardToBalanceMap =
        calculateCreditCardBalancesFor(start: start, end: end);
    return creditCardToBalanceMap.values.fold(0.0, (sum, value) => sum + value);
  }

  List<double> generateBalances() {
    final transactions = _finvestDataHelper.transactions;
    final min = transactions
        .map((transaction) => transaction.value)
        .reduce((a, b) => a < b ? a : b);
    final max = transactions
        .map((transaction) => transaction.value)
        .reduce((a, b) => a > b ? a : b);

    final random = Random();
    List<double> randomValues = List.generate(5, (index) {
      return min + (max - min) * random.nextDouble();
    });

    return randomValues;
  }
}
