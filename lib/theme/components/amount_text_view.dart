import 'package:finvest_credit_card_account/theme/app_colors.dart';
import 'package:finvest_credit_card_account/theme/theme_ext.dart';
import 'package:flutter/material.dart';

class AmountTextView extends StatelessWidget {
  final String integral;
  final String decimal;
  final TextStyle Function(BuildContext context) styleBuilder;

  const AmountTextView({
    super.key,
    required this.integral,
    required this.decimal,
    this.styleBuilder = _defaultStyleBuilder,
  });

  static TextStyle _defaultStyleBuilder(BuildContext context) =>
      context.typography.subHeading2.copyWith(color: AppColors.teal);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: integral,
        style: styleBuilder(context),
        children: [
          TextSpan(
            text: decimal,
            style: styleBuilder(context)
                .copyWith(fontFeatures: [const FontFeature.superscripts()]),
          )
        ],
      ),
    );
  }
}
