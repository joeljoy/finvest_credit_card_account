import 'package:finvest_credit_card_account/common/credit_card/domain/entities/credit_card_with_balance.dart';
import 'package:finvest_credit_card_account/features/home/widgets/home_component_template_widget.dart';
import 'package:finvest_credit_card_account/theme/app_colors.dart';
import 'package:finvest_credit_card_account/theme/components/app_text_button.dart';
import 'package:flutter/material.dart';

class CreditCardHomeWidget extends HomeComponentTemplateWidget {
  final List<CreditCardWithBalance> creditCardList;
  const CreditCardHomeWidget({super.key, required this.creditCardList});

  @override
  String getTitle() {
    return "Credit cards";
  }

  @override
  List<HomeComponentWidgetItem> getItems() {
    return creditCardList.map((creditCard) {
      return HomeComponentWidgetItem(
        title: creditCard.creditCard.name,
        description: creditCard.creditCard.maskedNumber,
        amount: creditCard.balance,
        imageSource: 'assets/wells_fargo_logo.png',
      );
    }).toList(growable: false);
  }

  @override
  int getItemsCount() {
    return creditCardList.length;
  }

  @override
  Widget getFooterButton() {
    return AppTextButton(
      label: "Add Account",
      leadingIcon: const Icon(Icons.add, size: 16, color: AppColors.blue),
      onTap: () {},
    );
  }
}
