import 'package:finvest_credit_card_account/common/credit_card/data/credit_card_data_source.dart';
import 'package:finvest_credit_card_account/common/credit_card/domain/credit_card_repository.dart';
import 'package:finvest_credit_card_account/common/credit_card/domain/entities/credit_card.dart';
import 'package:finvest_credit_card_account/common/credit_card/domain/entities/credit_card_with_balance.dart';

class AppCreditCardRepository implements CreditCardRepository {
  final CreditCardDataSource _creditCardDataSource;

  AppCreditCardRepository({required CreditCardDataSource creditCardDataSource})
      : _creditCardDataSource = creditCardDataSource;

  @override
  double getTotalBalance() {
    return _creditCardDataSource.calculateTotalBalance();
  }

  @override
  double getTotalBalanceForPeriod(
      {required DateTime start, required DateTime end}) {
    return _creditCardDataSource.calculateTotalBalanceForPeriod(
        start: start, end: end);
  }

  @override
  List<double> getBalances() {
    return _creditCardDataSource.generateBalances();
  }

  @override
  List<CreditCard> getAllCreditCards() {
    return _creditCardDataSource.getCreditCardList();
  }

  @override
  List<CreditCardWithBalance> getAllCreditCardsWithBalance() {
    final creditCardToBalanceMap =
        _creditCardDataSource.calculateCreditCardBalances();
    return _creditCardDataSource.getCreditCardList().map((card) {
      final balance = creditCardToBalanceMap[card.id] ??
          0.00; //if no credit cards found in transactions, then there is no due
      return CreditCardWithBalance(creditCard: card, balance: balance);
    }).toList(growable: false);
  }

  @override
  List<CreditCardWithBalance> getAllCreditCardsWithBalanceForPeriod({
    required DateTime start,
    required DateTime end,
  }) {
    final creditCardToBalanceMap = _creditCardDataSource
        .calculateCreditCardBalancesFor(start: start, end: end);
    return _creditCardDataSource.getCreditCardList().map((card) {
      final balance = creditCardToBalanceMap[card.id] ??
          0.00; //if no credit cards found in transactions, then there is no due
      return CreditCardWithBalance(creditCard: card, balance: balance);
    }).toList(growable: false);
  }
}
