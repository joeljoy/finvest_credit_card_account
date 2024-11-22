import 'package:finvest_credit_card_account/common/transactions/domain/entities/transaction.dart';
import 'package:finvest_credit_card_account/features/home/widgets/home_component_template_widget.dart';
import 'package:finvest_credit_card_account/theme/app_colors.dart';
import 'package:finvest_credit_card_account/theme/components/app_text_button.dart';
import 'package:finvest_credit_card_account/utils/data_and_time_util.dart';
import 'package:flutter/material.dart';

class TransactionHomeWidget extends HomeComponentTemplateWidget {
  final List<Transaction> transactions;
  const TransactionHomeWidget({super.key, required this.transactions});

  @override
  String getTitle() {
    return "Recent transactions";
  }

  @override
  List<HomeComponentWidgetItem> getItems() {
    return transactions.map((transaction) {
      final formattedDate = DataAndTimeUtil.formatDate(transaction.date);
      final description = StringBuffer(formattedDate);
      if (transaction.status == TransactionStatus.PENDING) {
        description.write(' • Pending');
      }
      return HomeComponentWidgetItem(
        title: transaction.merchantName,
        description: description.toString(),
        amount: transaction.value,
        imageSource: 'assets/wells_fargo_logo.png',
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
      onTap: () {},
    );
  }
}
