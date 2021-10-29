import 'dart:async';

import 'package:flutter/material.dart';

class AppStateManager extends ChangeNotifier {
  bool _initialized = false;
  bool _fightActive = false;
  bool _statisticActive = false;

  bool get isInitialized => _initialized;
  bool get isFightActive => _fightActive;
  bool get isStatisticActive => _statisticActive;

  void setFightActive() {
    _fightActive = true;

    notifyListeners();
  }

  void closeFightActive() {
    _fightActive = false;

    notifyListeners();
  }

  void setStatisticActive() {
    _statisticActive = true;

    notifyListeners();
  }

  void closeStatisticActive() {
    _statisticActive = false;

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
