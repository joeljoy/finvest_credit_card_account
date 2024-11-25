import 'package:finvest_credit_card_account/theme/app_colors.dart';
import 'package:finvest_credit_card_account/theme/app_spacing.dart';
import 'package:finvest_credit_card_account/theme/components/app_slider/app_slider.dart';
import 'package:finvest_credit_card_account/theme/theme_ext.dart';
import 'package:flutter/material.dart';

class TransactionFilterSliderWidget extends StatefulWidget {
  final String title;
  final double maxValue;
  final double minValue;
  const TransactionFilterSliderWidget(
      {super.key,
      required this.title,
      required this.maxValue,
      required this.minValue});

  @override
  State<TransactionFilterSliderWidget> createState() =>
      _TransactionFilterSliderWidgetState();
}

class _TransactionFilterSliderWidgetState
    extends State<TransactionFilterSliderWidget> {
  double min = 0;
  double max = 10000;

  @override
  void initState() {
    min = widget.minValue;
    max = widget.maxValue;
    super.initState();
  }

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
        AppSlider(
          min: 0.0,
          max: 10000,
          onRangeChanged: (minVaue, maxValue) {
            setState(() {
              min = minVaue;
              max = maxValue;
            });
          },
        ),
        const SizedBox(height: AppSpacing.small),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [_Amount(value: min), _Amount(value: max)],
        )
      ],
    );
  }
}

class _Amount extends StatelessWidget {
  final double value;
  const _Amount({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xsmall),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.grey2,
          width: 1,
        ),
      ),
      child: Center(
        child: Text('\$${value.truncate()}', style: context.typography.label),
      ),
    );
  }
}
