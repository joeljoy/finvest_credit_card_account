import 'package:finvest_credit_card_account/common/transactions/domain/entities/transaction.dart';
import 'package:finvest_credit_card_account/common/transactions/transaction_ui_util.dart';
import 'package:finvest_credit_card_account/features/home/widgets/home_component_template_widget.dart';
import 'package:finvest_credit_card_account/theme/app_colors.dart';
import 'package:finvest_credit_card_account/theme/components/app_text_button.dart';
import 'package:finvest_credit_card_account/utils/image_logo_util.dart';
import 'package:flutter/material.dart';

class TransactionHomeWidget extends HomeComponentTemplateWidget {
  final List<Transaction> transactions;
  final VoidCallback onFooterButtonTap;
  const TransactionHomeWidget({
    super.key,
    required this.transactions,
    required this.onFooterButtonTap,
  });

  @override
  String getTitle() {
    return "Recent transactions";
  }

  @override
  List<HomeComponentWidgetItem> getItems() {
    return transactions.map((transaction) {
      return HomeComponentWidgetItem(
        title: transaction.merchantName,
        description: transaction.description,
        amount: transaction.value,
        imageSource: ImageLogoUtil.getLogoForName(transaction.merchantName),
      );
    }).toList(growable: false);
  }

  @override
  int getItemsCount() {
    return transactions.length;
  }

  @override
  Widget getFooterButton() {
    return AppTextButton(
      label: "See all transactions",
      trailingIcon:
          const Icon(Icons.navigate_next, size: 16, color: AppColors.blue),
      onTap: onFooterButtonTap,
    );
  }
}
