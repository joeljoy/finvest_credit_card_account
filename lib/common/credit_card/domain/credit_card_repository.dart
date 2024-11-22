import 'package:finvest_credit_card_account/common/credit_card/domain/entities/credit_card.dart';
import 'package:finvest_credit_card_account/common/credit_card/domain/entities/credit_card_with_balance.dart';

abstract class CreditCardRepository {
  List<CreditCard> getAllCreditCards();
  List<CreditCardWithBalance> getAllCreditCardsWithBalance();
  double getTotalBalance();
}
