import 'package:finvest_credit_card_account/theme/app_spacing.dart';
import 'package:finvest_credit_card_account/theme/theme_ext.dart';
import 'package:flutter/material.dart';

class FinancialTile extends StatelessWidget {
  final String value;
  final String title;
  final String? imageSource;
  final String? description;

  const FinancialTile({
    super.key,
    required this.value,
    required this.title,
    this.imageSource,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (imageSource != null) ...[
          Image.asset(imageSource!),
          const SizedBox(width: AppSpacing.small)
        ],
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: context.typography.subHeading2),
            Text(
              description ?? "",
              style: context.typography.body,
            )
          ],
        ),
        const Spacer(),
        Text(value, style: context.typography.subHeading2),
      ],
    );
  }
}
