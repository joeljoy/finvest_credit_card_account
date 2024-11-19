import 'package:finvest_credit_card_account/theme/app_theme.dart';
import 'package:finvest_credit_card_account/theme/app_typography.dart';
import 'package:flutter/material.dart';

extension ThemeExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  AppTypography get typography =>
      theme.extension<AppTheme>()!.appTypography as AppTypography;
}
