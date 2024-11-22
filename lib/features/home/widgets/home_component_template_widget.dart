import 'package:finvest_credit_card_account/theme/app_colors.dart';
import 'package:finvest_credit_card_account/theme/app_shadows.dart';
import 'package:finvest_credit_card_account/theme/app_spacing.dart';
import 'package:finvest_credit_card_account/theme/components/app_divider.dart';
import 'package:finvest_credit_card_account/theme/components/financial_tile.dart';
import 'package:finvest_credit_card_account/theme/theme_ext.dart';
import 'package:finvest_credit_card_account/utils/currency_utils.dart';
import 'package:flutter/material.dart';

abstract class HomeComponentTemplateWidget extends StatelessWidget {
  const HomeComponentTemplateWidget({super.key});
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
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            getTitle(),
            style:
                context.typography.subHeading1.copyWith(color: AppColors.teal),
          ),
          const _DividerWithPadding(),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = getItems()[index];
              final amount =
                  CurrencyUtils.getFormattedAmount(amount: item.amount);
              return FinancialTile(
                integral: amount.$1,
                decimal: amount.$2,
                title: item.title,
                description: item.description,
                imageSource: item.imageSource,
              );
            },
            separatorBuilder: (_, __) => const _DividerWithPadding(),
            itemCount: getItemsCount(),
          ),
          ...[
            const SizedBox(height: AppSpacing.small),
            const AppDivider(),
          ],
          Center(child: getFooterButton())
        ],
      ),
    );
  }

  String getTitle();
  List<HomeComponentWidgetItem> getItems();
  int getItemsCount();
  Widget getFooterButton();
}

class _DividerWithPadding extends StatelessWidget {
  const _DividerWithPadding();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: AppSpacing.small),
        AppDivider(),
        SizedBox(height: AppSpacing.small),
      ],
    );
  }
}

class HomeComponentWidgetItem {
  final String title;
  final String description;
  final num amount;
  final String imageSource;

  HomeComponentWidgetItem({
    required this.title,
    required this.description,
    required this.amount,
    required this.imageSource,
  });
}
