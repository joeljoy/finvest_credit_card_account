import 'package:finvest_credit_card_account/theme/app_colors.dart';
import 'package:finvest_credit_card_account/theme/app_spacing.dart';
import 'package:finvest_credit_card_account/theme/theme_ext.dart';
import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final String label;
  final Icon? trailingIcon;
  final Icon? leadingIcon;
  final Color? textColor;
  final VoidCallback onTap;

  const AppTextButton({
    super.key,
    required this.label,
    this.trailingIcon,
    this.leadingIcon,
    this.textColor = AppColors.teal,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null) ...[
            leadingIcon!,
          ],
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxsmall),
            child: Text(
              label.toUpperCase(),
              style: context.typography.subHeading3.copyWith(color: textColor),
            ),
          ),
          if (trailingIcon != null) ...[
            trailingIcon!,
          ]
        ],
      ),
    );
  }
}
