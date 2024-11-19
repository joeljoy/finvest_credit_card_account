import 'package:finvest_credit_card_account/common/credit_card/domain/entities/credit_card.dart';

class CreditCardWithBalance {
  final CreditCard creditCard;
  final double balance;

  CreditCardWithBalance({required this.creditCard, required this.balance});
}
