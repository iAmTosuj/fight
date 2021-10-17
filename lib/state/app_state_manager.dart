import 'dart:async';

import 'package:flutter/material.dart';

class AppStateManager extends ChangeNotifier {
  bool _initialized = false;
  bool _fightActive = false;

  bool get isInitialized => _initialized;
  bool get isFightActive => _fightActive;

  void setFightActive() {
    _fightActive = true;

    notifyListeners();
  }

  void initializeApp() {
    Timer(
      const Duration(milliseconds: 2000),
      () {
        _initialized = true;
        notifyListeners();
      },
    );
  }
}
