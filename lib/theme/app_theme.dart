import 'package:finvest_credit_card_account/theme/app_typography.dart';
import 'package:flutter/material.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  final ThemeExtension<AppTypography> appTypography;

  AppTheme({required this.appTypography});

  @override
  ThemeExtension<AppTheme> copyWith({
    ThemeExtension<AppTypography>? appTypography,
  }) {
    return AppTheme(appTypography: appTypography ?? this.appTypography);
  }

  @override
  ThemeExtension<AppTheme> lerp(
      covariant ThemeExtension<AppTheme>? other, double t) {
    if (other is! AppTheme) {
      return this;
    }

    return AppTheme(
      appTypography: appTypography.lerp(other.appTypography, t),
    );
  }
}
