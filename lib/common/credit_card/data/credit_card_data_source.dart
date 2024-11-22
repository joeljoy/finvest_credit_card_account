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

  double calculateTotalBalance() {
    final creditCardToBalanceMap = calculateCreditCardBalances();
    return creditCardToBalanceMap.values.fold(0.0, (sum, value) => sum + value);
  }
}
