import 'package:collection/collection.dart';
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
    return _creditCardDataSource.generateCreditCardList(2);
  }

  @override
  List<CreditCardWithBalance> getAllCreditCardsWithBalance() {
    return _creditCardDataSource.generateCreditCardList(2).mapIndexed(
      (idx, creditCard) {
        return CreditCardWithBalance(
          creditCard: creditCard,
          balance: 112343.toDouble() + idx,
        );
      },
    ).toList(growable: false);
  }
}
