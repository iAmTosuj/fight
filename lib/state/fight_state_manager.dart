import 'package:flutter/material.dart';
import 'package:flutter_fight_club/core/body_part.dart';
import 'package:flutter_fight_club/core/fight_result.dart';

class FightStateManager extends ChangeNotifier {
  static const maxLives = 5;

  bool _active = false;

  BodyPart? _defendingBodyPart;
  BodyPart? _attackingBodyPart;
  int _yourLives = maxLives;
  int _enemyLives = maxLives;
  String _youFightInfoText = '';
  String _enemyFightInfoText = '';
  String _gameOverText = '';
  BodyPart _whatEnemyAttacks = BodyPart.random();
  BodyPart _whatEnemyDefends = BodyPart.random();

  bool get isActive => _active;
  BodyPart? get defendingBodyPart => _defendingBodyPart;
  BodyPart? get attackingBodyPart => _attackingBodyPart;
  int get yourLives => _yourLives;
  int get enemyLives => _enemyLives;
  String get youFightInfoText => _youFightInfoText;
  String get gameOverText => _gameOverText;
  String get enemyFightInfoText => _enemyFightInfoText;
  BodyPart get whatEnemyAttacks => _whatEnemyAttacks;
  BodyPart get whatEnemyDefends => _whatEnemyDefends;

  bool isGameOver() {
    return (_yourLives == 0 || _enemyLives == 0);
  }

  bool isAllBtnSelected() {
    return !(_defendingBodyPart == null || _attackingBodyPart == null);
  }

  void setActive() {
    _active = true;

    notifyListeners();
  }

  void pressGo() {
    final bool enemyLoseLife = _attackingBodyPart != _whatEnemyDefends;
    final bool youLoseLife = _defendingBodyPart != _whatEnemyAttacks;
    var gameOverText = '';
    var youFightInfoText = 'Your attack was blocked.';
    var enemyFightInfoText = 'Enemy’s attack was blocked.';

    if (enemyLoseLife) {
      _enemyLives -= 1;

      youFightInfoText = 'Your hit enemy ${_attackingBodyPart!.name}.';
    }

    if (youLoseLife) {
      _yourLives -= 1;

      enemyFightInfoText = 'Enemy hit your ${_whatEnemyAttacks.name}.';
    }

    final FightResult? fightResult =
        FightResult.calculateResult(yourLives, enemyLives);

    if (fightResult != null) {
      gameOverText = fightResult.result;

      notifyListeners();

      _clearState();

      return;
    }

    _youFightInfoText = youFightInfoText;
    _enemyFightInfoText = enemyFightInfoText;
    _gameOverText = gameOverText;
    _defendingBodyPart = null;
    _attackingBodyPart = null;

    notifyListeners();
  }

  void setDefend(BodyPart part) {
    _defendingBodyPart = part;

    notifyListeners();
  }

  void setAttack(BodyPart part) {
    _attackingBodyPart = part;

    notifyListeners();
  }

  void _clearState() {
    _defendingBodyPart = null;
    _attackingBodyPart = null;
    _yourLives = maxLives;
    _enemyLives = maxLives;
    _youFightInfoText = '';
    _enemyFightInfoText = '';
    _gameOverText = '';
    _whatEnemyAttacks = BodyPart.random();
    _whatEnemyDefends = BodyPart.random();
  }
}
