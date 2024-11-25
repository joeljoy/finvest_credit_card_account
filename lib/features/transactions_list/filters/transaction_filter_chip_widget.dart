import 'package:finvest_credit_card_account/features/transactions_list/transaction_chip.dart';
import 'package:finvest_credit_card_account/theme/app_colors.dart';
import 'package:finvest_credit_card_account/theme/app_spacing.dart';
import 'package:finvest_credit_card_account/theme/components/app_chip.dart';
import 'package:finvest_credit_card_account/theme/theme_ext.dart';
import 'package:flutter/material.dart';

class TransactionFilterChipWidget extends StatefulWidget {
  final String title;
  final List<TransactionChip> chips;
  final Function(TransactionChip? previous, TransactionChip current)
      onFilterChanged;
  const TransactionFilterChipWidget({
    super.key,
    required this.title,
    required this.chips,
    required this.onFilterChanged,
  });

  @override
  State<TransactionFilterChipWidget> createState() =>
      _TransactionFilterChipWidgetState();
}

class _TransactionFilterChipWidgetState
    extends State<TransactionFilterChipWidget> {
  late TransactionChip _selectedChip;
  @override
  void initState() {
    _selectedChip = widget.chips.firstWhere((chip) {
      return chip.isActive;
    });
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
        Wrap(
          spacing: AppSpacing.xsmall,
          runSpacing: AppSpacing.xsmall,
          children: widget.chips.map((chip) {
            return AppChip(
                label: chip.label,
                isSelected: chip.id == _selectedChip.id,
                activeBackgroundColor: AppColors.lightBlue,
                inactiveBackgroundColor: AppColors.transparent,
                activeBorderColor: AppColors.teal,
                inactiveBorderColor: AppColors.grey2,
                onTap: () {
                  final previous = _selectedChip;
                  final current = chip;
                  setState(() {
                    _selectedChip = chip;
                  });
                  widget.onFilterChanged(previous, current);
                });
          }).toList(growable: false),
        )
      ],
    );
  }
}
