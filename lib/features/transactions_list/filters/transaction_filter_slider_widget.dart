import 'package:finvest_credit_card_account/theme/app_colors.dart';
import 'package:finvest_credit_card_account/theme/app_spacing.dart';
import 'package:finvest_credit_card_account/theme/components/app_slider/app_slider.dart';
import 'package:finvest_credit_card_account/theme/theme_ext.dart';
import 'package:flutter/material.dart';

class TransactionFilterSliderWidget extends StatefulWidget {
  final String title;
  const TransactionFilterSliderWidget({super.key, required this.title});

  @override
  State<TransactionFilterSliderWidget> createState() =>
      _TransactionFilterSliderWidgetState();
}

class _TransactionFilterSliderWidgetState
    extends State<TransactionFilterSliderWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.title,
          style: context.typography.subHeading1.copyWith(color: AppColors.teal),
        ),
        const SizedBox(height: AppSpacing.small),
        const AppSlider(min: 0.0, max: 10000),
        const SizedBox(height: AppSpacing.small),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            _Amount(
              value: "\$0",
            ),
            _Amount(value: "\$10000")
          ],
        )
      ],
    );
  }
}

class _Amount extends StatelessWidget {
  final String value;
  const _Amount({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.grey,
          width: 1,
        ),
      ),
      child: Center(
        child: Text(value, style: context.typography.label),
      ),
    );
  }
}
