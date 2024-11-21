import 'package:finvest_credit_card_account/common/credit_card/domain/entities/credit_card_with_balance.dart';
import 'package:finvest_credit_card_account/theme/app_colors.dart';
import 'package:finvest_credit_card_account/theme/app_shadows.dart';
import 'package:finvest_credit_card_account/theme/app_spacing.dart';
import 'package:finvest_credit_card_account/theme/components/app_text_button.dart';
import 'package:finvest_credit_card_account/theme/components/app_divider.dart';
import 'package:finvest_credit_card_account/theme/components/financial_tile.dart';
import 'package:finvest_credit_card_account/theme/theme_ext.dart';
import 'package:finvest_credit_card_account/utils/currency_utils.dart';
import 'package:flutter/material.dart';

class CreditCardListWidget extends StatelessWidget {
  final List<CreditCardWithBalance> creditCardList;
  const CreditCardListWidget({super.key, required this.creditCardList});
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
            "Credit Cards",
            style:
                context.typography.subHeading1.copyWith(color: AppColors.teal),
          ),
          const _DividerWithPadding(),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final card = creditCardList[index];
              final amount =
                  CurrencyUtils.getFormattedAmount(amount: card.balance);
              return FinancialTile(
                integral: amount.$1,
                decimal: amount.$2,
                title: card.creditCard.name,
                description: card.creditCard.maskedNumber,
                imageSource: 'assets/wells_fargo_logo.png',
              );
            },
            separatorBuilder: (_, __) => const _DividerWithPadding(),
            itemCount: creditCardList.length,
          ),
          ...[
            const SizedBox(height: AppSpacing.small),
            const AppDivider(),
          ],
          Center(
            child: AppTextButton(
                label: "Add Account",
                leadingIcon:
                    const Icon(Icons.add, size: 16, color: AppColors.blue),
                onTap: () {}),
          )
        ],
      ),
    );
  }
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
