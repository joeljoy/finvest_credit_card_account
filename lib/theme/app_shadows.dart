import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  static final container = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 8,
    )
  ];

  static const divider = [
    BoxShadow(
      color: Color(0xFFFFFFFF),
      offset: Offset(0, 1),
      blurRadius: 0,
      spreadRadius: 0,
    ),
  ];
}
