import 'package:finvest_credit_card_account/theme/app_colors.dart';
import 'package:finvest_credit_card_account/theme/theme_ext.dart';
import 'package:flutter/material.dart';

class AppChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color activeBackgroundColor;
  final Color inactiveBackgroundColor;
  final Color activeBorderColor;
  final Color inactiveBorderColor;
  final int? counter;
  final IconData? iconData;
  final Widget Function(BuildContext context)? iconBuilder;

  const AppChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.activeBackgroundColor,
    required this.inactiveBackgroundColor,
    required this.activeBorderColor,
    required this.inactiveBorderColor,
    this.counter,
    this.iconData,
    this.iconBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? activeBackgroundColor : inactiveBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? activeBorderColor : inactiveBorderColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (counter != null) ...[
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppColors.blue,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  counter.toString(),
                  style:
                      context.typography.label.copyWith(color: AppColors.white),
                ),
              ),
              const SizedBox(width: 8)
            ],
            Text(
              label,
              style: context.typography.label.copyWith(color: AppColors.teal),
            ),
            if (iconBuilder != null) ...[
              const SizedBox(width: 8),
              iconBuilder!(context)
            ],
            if (iconData != null) ...[
              const SizedBox(width: 8),
              Icon(
                iconData,
                size: 16,
                color: AppColors.teal,
              )
            ]
          ],
        ),
      ),
    );
  }
}
