import 'package:finvest_credit_card_account/theme/app_colors.dart';
import 'package:finvest_credit_card_account/theme/theme_ext.dart';
import 'package:flutter/material.dart';

class AmountTextView extends StatelessWidget {
  final String integral;
  final String decimal;

  const AmountTextView({
    super.key,
    required this.integral,
    required this.decimal,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: integral,
        style: context.typography.subHeading2.copyWith(color: AppColors.teal),
        children: [
          TextSpan(
            text: decimal,
            style: context.typography.subHeading2.copyWith(
              color: AppColors.teal,
              fontFeatures: [const FontFeature.superscripts()],
            ),
          )
        ],
      ),
    );
  }
}
