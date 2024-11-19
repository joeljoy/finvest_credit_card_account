import 'dart:math';

import 'package:finvest_credit_card_account/common/credit_card/domain/entities/credit_card.dart';

class CreditCardDataSource {
  final cardNames = [
    'City Gold',
    'WellsFargo Platinum',
    'Chase Sapphire',
    'Amex Gold',
    'Discover It'
  ];

  List<CreditCard> generateCreditCardList(int count) {
    final random = Random();
    final List<CreditCard> creditCards = [];
    for (int i = 0; i < count; i++) {
      final id = 'CC-${random.nextInt(1000000).toString().padLeft(6, '0')}';
      final maskedNumber =
          '**** **** **** ${random.nextInt(10000).toString().padLeft(4, '0')}';
      final name = cardNames[random.nextInt(cardNames.length)];

      creditCards.add(CreditCard(
        id: id,
        maskedNumber: maskedNumber,
        name: name,
      ));
    }

    return creditCards;
  }
}
