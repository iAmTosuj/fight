import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/core/body_part.dart';
import 'package:flutter_fight_club/core/fight_result.dart';
import 'package:flutter_fight_club/ui/fight_page/controls_widget.dart';
import 'package:flutter_fight_club/ui/fight_page/fighters_info.dart';
import 'package:flutter_fight_club/ui/fight_page/info_board.dart';
import 'package:flutter_fight_club/ui/widgets/action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resources/colors.dart';
import '../../resources/icons.dart';
import '../../resources/images.dart';

class FightPage extends StatefulWidget {
  FightPage({Key? key}) : super(key: key);

  @override
  FightPageState createState() => FightPageState();
}

class FightPageState extends State<FightPage> {
  static const maxLives = 5;
  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;
  int yourLives = maxLives;
  int enemysLives = maxLives;
  String youFightInfoText = '';
  String enemyFightInfoText = '';
  String gameOverText = '';
  BodyPart whatEnemyAttacks = BodyPart.random();
  BodyPart whatEnemyDefends = BodyPart.random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            FightersInfo(
              maxLivesCount: maxLives,
              enemyLivesCount: enemysLives,
              yourLivesCount: yourLives,
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: ColoredBox(
                    color: Color.fromRGBO(197, 209, 234, 1),
                    child: InfoBoard(
                      enemyText: enemyFightInfoText,
                      youText: youFightInfoText,
                      gameOverText: gameOverText,
                    ),
                  )),
            )),
            ControlsWidget(
              selectAttackingPart: _selectAttackingPart,
              selectDefendingPart: _selectDefendingPart,
              attackingBodyPart: attackingBodyPart,
              defendingBodyPart: defendingBodyPart,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              child: ActionButton(
                text: _isGameOver() ? 'Start new game' : 'GO',
                color: _isGameOver()
                    ? FightClubColors.blackButton
                    : _isAllBtnSelected()
                        ? FightClubColors.blackButton
                        : FightClubColors.greyButton,
                onTap: _onGoButtonClicked,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onGoButtonClicked() {
    if (!_isAllBtnSelected() && !_isGameOver()) {
      return;
    }

    if (_isGameOver()) {
      setState(() {
        gameOverText = '';
        youFightInfoText = '';
        enemyFightInfoText = '';
        enemysLives = maxLives;
        yourLives = maxLives;
      });

      Navigator.of(context).pop();

      return;
    }

    final bool enemyLoseLife = attackingBodyPart != whatEnemyDefends;
    final bool youLoseLife = defendingBodyPart != whatEnemyAttacks;

    setState(() {
      youFightInfoText = 'Your attack was blocked.';
      enemyFightInfoText = 'Enemy’s attack was blocked.';

      if (enemyLoseLife) {
        enemysLives -= 1;
        youFightInfoText = 'Your hit enemy ${attackingBodyPart!.name}.';
      }

      if (youLoseLife) {
        yourLives -= 1;
        enemyFightInfoText = 'Enemy hit your ${whatEnemyAttacks.name}.';
      }

      final FightResult? fightResult =
          FightResult.calculateResult(yourLives, enemysLives);
      if (fightResult != null) {
        gameOverText = fightResult.result;

        SharedPreferences.getInstance().then((sharedPreferences) =>
            sharedPreferences.setString(
                'last_fight_result', fightResult.result));
      }

      whatEnemyAttacks = BodyPart.random();
      whatEnemyDefends = BodyPart.random();

      defendingBodyPart = null;
      attackingBodyPart = null;
    });
  }

  bool _isAllBtnSelected() {
    return !(defendingBodyPart == null || attackingBodyPart == null);
  }

  bool _isGameOver() {
    return (yourLives == 0 || enemysLives == 0);
  }

  void _selectDefendingPart(final BodyPart value) {
    if (_isGameOver()) {
      return;
    }

    setState(() {
      defendingBodyPart = value;
    });
  }

  void _selectAttackingPart(final BodyPart value) {
    if (_isGameOver()) {
      return;
    }

    setState(() {
      attackingBodyPart = value;
    });
  }
}








