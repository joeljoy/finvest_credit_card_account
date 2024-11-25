import 'package:finvest_credit_card_account/features/transactions_list/filters/transaction_filter_chip_widget.dart';
import 'package:finvest_credit_card_account/features/transactions_list/filters/transaction_filter_slider_widget.dart';
import 'package:finvest_credit_card_account/features/transactions_list/filters/transaction_filter_view_model.dart';
import 'package:finvest_credit_card_account/theme/app_colors.dart';
import 'package:finvest_credit_card_account/theme/app_spacing.dart';
import 'package:finvest_credit_card_account/theme/components/app_divider.dart';
import 'package:finvest_credit_card_account/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionFilterView extends StatefulWidget {
  const TransactionFilterView({super.key});

  @override
  State<TransactionFilterView> createState() => _TransactionFilterViewState();
}

class _TransactionFilterViewState extends State<TransactionFilterView> {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TransactionFilterViewModel>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.small),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 8),
          Center(
            child: Container(
              color: const Color(0xFF94A3B8),
              height: 2,
              width: 24,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "Filters",
            style: context.typography.heading
                .copyWith(color: AppColors.teal, fontSize: 24),
          ),
          const SizedBox(height: AppSpacing.small),
          const AppDivider(),
          const SizedBox(height: AppSpacing.small),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: AppSpacing.small),
              itemBuilder: (context, index) {
                final filter = TransactionFilterTypes.values[index];
                if (filter == TransactionFilterTypes.AMOUNT) {
                  return const TransactionFilterSliderWidget(title: "Amount");
                } else {
                  final items = vm.getItemsForFilter(filter);
                  return TransactionFilterChipWidget(
                    title: filter.label,
                    chips: items,
                    onTap: () {},
                  );
                }
              },
              separatorBuilder: (context, index) {
                return const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: AppSpacing.xsmall),
                    AppDivider(),
                    SizedBox(height: AppSpacing.small)
                  ],
                );
              },
              itemCount: TransactionFilterTypes.values.length,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.white, width: 1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.teal, width: 1),
                      color: AppColors.transparent,
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Handle "Clear all" action
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),
                      child: Text(
                        "Clear all",
                        style: context.typography.subHeading2
                            .copyWith(color: AppColors.teal),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.small),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.teal,
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Handle "Apply" action
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),
                      child: Text(
                        "Apply",
                        style: context.typography.subHeading2
                            .copyWith(color: AppColors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
