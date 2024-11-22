import 'package:finvest_credit_card_account/common/credit_card/data/credit_card_data_source.dart';
import 'package:finvest_credit_card_account/common/credit_card/domain/credit_card_repository.dart';
import 'package:finvest_credit_card_account/common/credit_card/domain/entities/credit_card.dart';
import 'package:finvest_credit_card_account/common/credit_card/domain/entities/credit_card_with_balance.dart';

class AppCreditCardRepository implements CreditCardRepository {
  final CreditCardDataSource _creditCardDataSource;

  AppCreditCardRepository({required CreditCardDataSource creditCardDataSource})
      : _creditCardDataSource = creditCardDataSource;

  @override
  List<CreditCard> getAllCreditCards() {
    return _creditCardDataSource.getCreditCardList();
  }

  @override
  List<CreditCardWithBalance> getAllCreditCardsWithBalance() {
    final creditCardToBalanceMap =
        _creditCardDataSource.calculateCreditCardBalances();
    return _creditCardDataSource.getCreditCardList().map((card) {
      final balance = creditCardToBalanceMap[card.id]!;
      return CreditCardWithBalance(creditCard: card, balance: balance);
    }).toList(growable: false);
  }
}
