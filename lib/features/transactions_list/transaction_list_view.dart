import 'package:finvest_credit_card_account/common/transactions/domain/entities/transaction.dart';
import 'package:finvest_credit_card_account/common/transactions/transaction_ui_util.dart';
import 'package:finvest_credit_card_account/features/transactions_list/transaction_list_view_model.dart';
import 'package:finvest_credit_card_account/theme/app_colors.dart';
import 'package:finvest_credit_card_account/theme/app_shadows.dart';
import 'package:finvest_credit_card_account/theme/app_spacing.dart';
import 'package:finvest_credit_card_account/theme/components/app_divider.dart';
import 'package:finvest_credit_card_account/theme/components/financial_tile.dart';
import 'package:finvest_credit_card_account/utils/currency_utils.dart';
import 'package:finvest_credit_card_account/utils/image_logo_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionListView extends StatefulWidget {
  const TransactionListView({super.key});

  @override
  State<TransactionListView> createState() => _TransactionListViewState();
}

class _TransactionListViewState extends State<TransactionListView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Provider.of<TransactionListViewModel>(context, listen: false)
          .initialiseDataSource(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Consumer<TransactionListViewModel>(
        builder: (context, vm, child) {
          return _Body(viewModel: vm);
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final TransactionListViewModel viewModel;
  const _Body({super.key, required this.viewModel});

  List<Transaction> get transactions => viewModel.transactions;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: AppSpacing.small,
          left: AppSpacing.small,
          right: AppSpacing.small),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppShadows.container,
        border: Border.all(
          color: AppColors.white,
          width: 1.0,
        ),
      ),
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            viewModel.loadMore();
          }
          return true;
        },
        child: ListView.separated(
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            final amount =
                CurrencyUtils.getFormattedAmount(amount: transaction.value);
            return FinancialTile(
              integral: amount.$1,
              decimal: amount.$2,
              title: transaction.merchantName,
              description: transaction.description,
              imageSource:
                  ImageLogoUtil.getLogoForName(transaction.merchantName),
            );
          },
          separatorBuilder: (_, __) => const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: AppSpacing.small),
              AppDivider(),
              SizedBox(height: AppSpacing.small),
            ],
          ),
          itemCount: transactions.length,
        ),
      ),
    );
  }
}
