import 'package:flutter/material.dart';

abstract class ViewModel extends ChangeNotifier {
  bool isDisposed = false;

  @override
  void notifyListeners() {
    if (!isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
