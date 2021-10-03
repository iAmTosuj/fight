import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/core/fight_result.dart';
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

class InfoBoard extends StatelessWidget {
  final String enemyText;
  final String youText;
  final String gameOverText;

  const InfoBoard(
      {Key? key,
      required this.enemyText,
      required this.youText,
      required this.gameOverText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      getActualText(),
      style: TextStyle(
        fontSize: 10,
        color: FightClubColors.darkGreyText,
      ),
      textAlign: TextAlign.center,
    ));
  }

  String getActualText() {
    if (gameOverText.length != 0) {
      return gameOverText;
    }

    if (youText.length != 0 && enemyText.length != 0) {
      return '$youText\n$enemyText';
    }

    return '';
  }
}

class ControlsWidget extends StatelessWidget {
  final BodyPart? defendingBodyPart;
  final ValueSetter<BodyPart> selectDefendingPart;
  final BodyPart? attackingBodyPart;
  final ValueSetter<BodyPart> selectAttackingPart;

  const ControlsWidget(
      {Key? key,
      required this.defendingBodyPart,
      required this.selectDefendingPart,
      required this.attackingBodyPart,
      required this.selectAttackingPart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 16,
        ),
        Expanded(
            child: Column(
          children: [
            Text('DEFEND',
                style: TextStyle(color: FightClubColors.darkGreyText)),
            SizedBox(
              height: 13,
            ),
            BodyPartButton(
              bodyPart: BodyPart.head,
              selected: defendingBodyPart == BodyPart.head,
              bodyPartSetter: selectDefendingPart,
            ),
            BodyPartButton(
              bodyPart: BodyPart.torso,
              selected: defendingBodyPart == BodyPart.torso,
              bodyPartSetter: selectDefendingPart,
            ),
            BodyPartButton(
              bodyPart: BodyPart.legs,
              selected: defendingBodyPart == BodyPart.legs,
              bodyPartSetter: selectDefendingPart,
            ),
          ],
        )),
        SizedBox(
          width: 12,
        ),
        Expanded(
            child: Column(
          children: [
            Text('ATTACK',
                style: TextStyle(color: FightClubColors.darkGreyText)),
            SizedBox(
              height: 13,
            ),
            BodyPartButton(
              bodyPart: BodyPart.head,
              selected: attackingBodyPart == BodyPart.head,
              bodyPartSetter: selectAttackingPart,
            ),
            BodyPartButton(
              bodyPart: BodyPart.torso,
              selected: attackingBodyPart == BodyPart.torso,
              bodyPartSetter: selectAttackingPart,
            ),
            BodyPartButton(
              bodyPart: BodyPart.legs,
              selected: attackingBodyPart == BodyPart.legs,
              bodyPartSetter: selectAttackingPart,
            ),
          ],
        )),
        SizedBox(
          width: 16,
        )
      ],
    );
  }
}

class FightersInfo extends StatelessWidget {
  final int maxLivesCount;
  final int yourLivesCount;
  final int enemyLivesCount;

  const FightersInfo({
    Key? key,
    required this.maxLivesCount,
    required this.yourLivesCount,
    required this.enemyLivesCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 160,
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: ColoredBox(
                  color: Colors.white,
                )),
                Expanded(
                    child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.white,
                    Color.fromRGBO(197, 209, 234, 1)
                  ])),
                )),
                Expanded(
                    child: ColoredBox(color: Color.fromRGBO(197, 209, 234, 1))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                LivesWidget(
                    overallLivesCount: maxLivesCount,
                    currentLivesCount: yourLivesCount),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text('You',
                          style:
                              TextStyle(color: FightClubColors.darkGreyText)),
                    ),
                    Image.asset(
                      FightClubImages.youAvatar,
                      height: 92,
                      width: 92,
                    )
                  ],
                ),
                SizedBox(
                  height: 44,
                  width: 44,
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: FightClubColors.blueButton),
                      child: Center(
                        child: Text(
                          'vs',
                          style: TextStyle(color: FightClubColors.whiteText),
                        ),
                      )),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text('Enemy',
                          style:
                              TextStyle(color: FightClubColors.darkGreyText)),
                    ),
                    Image.asset(
                      FightClubImages.enemyAvatar,
                      height: 92,
                      width: 92,
                    )
                  ],
                ),
                LivesWidget(
                    overallLivesCount: maxLivesCount,
                    currentLivesCount: enemyLivesCount)
              ],
            ),
          ],
        ));
  }
}

class BodyPart {
  final String name;
  const BodyPart._(this.name);

  static const head = BodyPart._('Head');
  static const torso = BodyPart._('Torso');
  static const legs = BodyPart._('legs');

  @override
  String toString() {
    return 'BodyPart{name: $name}';
  }

  static const List<BodyPart> _values = [head, torso, legs];

  static BodyPart random() {
    return _values[Random().nextInt(_values.length)];
  }
}

class LivesWidget extends StatelessWidget {
  final int overallLivesCount;
  final int currentLivesCount;

  const LivesWidget(
      {Key? key,
      required this.overallLivesCount,
      required this.currentLivesCount})
      : assert(overallLivesCount >= 1),
        assert(currentLivesCount >= 0),
        assert(currentLivesCount <= overallLivesCount),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(overallLivesCount, (index) {
        return Padding(
            padding:
                EdgeInsets.only(bottom: index < overallLivesCount - 1 ? 4 : 0),
            child: Image.asset(
              index < currentLivesCount
                  ? FightClubIcons.HeartFull
                  : FightClubIcons.HeartEmpty,
              width: 18,
              height: 18,
            ));
      }),
    );
  }
}

class BodyPartButton extends StatelessWidget {
  final BodyPart bodyPart;
  final bool selected;
  final ValueSetter<BodyPart> bodyPartSetter;

  const BodyPartButton(
      {Key? key,
      required this.bodyPart,
      required this.selected,
      required this.bodyPartSetter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => bodyPartSetter(bodyPart),
      child: SizedBox(
        height: 40,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: selected ? FightClubColors.blueButton : Colors.transparent,
              border: !selected
                  ? Border.all(color: FightClubColors.darkGreyText, width: 2)
                  : null),
          child: Center(
            child: Text(
              bodyPart.name.toUpperCase(),
              style: TextStyle(
                  color: selected
                      ? FightClubColors.whiteText
                      : FightClubColors.darkGreyText),
            ),
          ),
        ),
      ),
    );
  }
}
