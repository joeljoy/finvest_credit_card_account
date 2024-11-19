import 'package:flutter/material.dart';

interface class AppTypography extends ThemeExtension<AppTypography> {
  final TextStyle heading;
  final TextStyle subHeading1;
  final TextStyle subHeading2;
  final TextStyle subHeading3;
  final TextStyle label;
  final TextStyle body;

  AppTypography({
    required this.heading,
    required this.subHeading1,
    required this.subHeading2,
    required this.subHeading3,
    required this.label,
    required this.body,
  });

  @override
  ThemeExtension<AppTypography> copyWith({
    TextStyle? heading,
    TextStyle? subHeading1,
    TextStyle? subHeading2,
    TextStyle? subHeading3,
    TextStyle? label,
    TextStyle? body,
  }) {
    return AppTypography(
      heading: heading ?? this.heading,
      subHeading1: subHeading1 ?? this.subHeading1,
      subHeading2: subHeading2 ?? this.subHeading2,
      subHeading3: subHeading3 ?? this.subHeading3,
      label: label ?? this.label,
      body: body ?? this.body,
    );
  }

  @override
  ThemeExtension<AppTypography> lerp(
      covariant ThemeExtension<AppTypography>? other, double t) {
    if (other is! AppTypography) {
      return this;
    }
    return AppTypography(
      heading: TextStyle.lerp(heading, other.heading, t)!,
      subHeading1: TextStyle.lerp(subHeading1, other.subHeading1, t)!,
      subHeading2: TextStyle.lerp(subHeading2, other.subHeading2, t)!,
      subHeading3: TextStyle.lerp(subHeading3, other.subHeading3, t)!,
      label: TextStyle.lerp(label, other.label, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
    );
  }
}

class AppRegularTypography extends AppTypography {
  AppRegularTypography({
    super.heading = const TextStyle(
      fontFamily: 'Maison Neue',
      fontSize: 40,
      fontWeight: FontWeight.w500,
      height: 48 / 40,
      letterSpacing: -2,
    ),
    super.subHeading1 = const TextStyle(
      fontFamily: 'Maison Neue',
      fontSize: 20,
      fontWeight: FontWeight.w500,
      height: 26 / 20,
      letterSpacing: -0.8,
    ),
    super.subHeading2 = const TextStyle(
      fontFamily: 'Maison Neue',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 24 / 16,
      letterSpacing: -0.6,
    ),
    super.subHeading3 = const TextStyle(
      fontFamily: 'Maison Neue',
      fontSize: 12,
      fontWeight: FontWeight.w600,
      height: 16 / 12,
      letterSpacing: 0.3,
    ),
    super.label = const TextStyle(
      fontFamily: 'Maison Neue',
      fontSize: 12,
      fontWeight: FontWeight.w600,
      height: 16 / 12,
      letterSpacing: 0.3,
    ),
    super.body = const TextStyle(
      fontFamily: 'Maison Neue',
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 18 / 12,
      letterSpacing: -0.3,
    ),
  });
}
