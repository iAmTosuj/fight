import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_club_images.dart';
import 'package:flutter_fight_club/fight_club_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import 'fight_club_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.pressStart2pTextTheme(
            Theme.of(context).textTheme,
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  static const maxLives = 5;
  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;
  int yourLives = maxLives;
  int enemyLives = maxLives;
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
              enemyLivesCount: enemyLives,
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
              child: GoButton(
                isGameOver: _isGameOver(),
                defendingBodyPart: defendingBodyPart,
                attackingBodyPart: attackingBodyPart,
                isAllBtnSelected: _isAllBtnSelected(),
                onTap: _onGoButtonClicked,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onGoButtonClicked() {
    if (_isGameOver()) {
      setState(() {
        gameOverText = '';
        youFightInfoText = '';
        enemyFightInfoText = '';
        enemyLives = maxLives;
        yourLives = maxLives;
      });

      return;
    }

    final bool enemyLoseLife = attackingBodyPart != whatEnemyDefends;
    final bool youLoseLife = defendingBodyPart != whatEnemyAttacks;

    setState(() {
      youFightInfoText = 'Your attack was blocked';
      enemyFightInfoText = 'Enemy’s attack was blocked';

      if (enemyLoseLife) {
        enemyLives -= 1;
        youFightInfoText = 'Your hit enemy ${attackingBodyPart!.name}';
      }

      if (youLoseLife) {
        yourLives -= 1;
        enemyFightInfoText = 'Enemy hit your ${whatEnemyAttacks.name}';
      }

      if (_isGameOver()) {
        if (enemyLives == 0 && yourLives == 0) {
          gameOverText = 'Draw';
        } else if (enemyLives == 0) {
          gameOverText = 'You won';
        } else if (yourLives == 0) {
          gameOverText = 'You lost';
        }
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
    return (enemyLives == 0 || enemyLives == 0);
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
      gameOverText.length != 0 ? gameOverText : '$youText\n\n$enemyText',
      style: TextStyle(
        fontSize: 10,
        color: FightClubColors.darkGreyText,
      ),
      textAlign: TextAlign.center,
    ));
  }
}

class GoButton extends StatelessWidget {
  final BodyPart? defendingBodyPart;
  final VoidCallback onTap;
  final BodyPart? attackingBodyPart;
  final bool isAllBtnSelected;
  final bool isGameOver;

  const GoButton(
      {Key? key,
      required this.defendingBodyPart,
      required this.onTap,
      required this.attackingBodyPart,
      required this.isGameOver,
      required this.isAllBtnSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          if (!isAllBtnSelected && !isGameOver) {
            return;
          }

          onTap();
        },
        child: SizedBox(
            height: 40,
            child: ColoredBox(
              color: isGameOver
                  ? FightClubColors.blackButton
                  : isAllBtnSelected
                      ? FightClubColors.blackButton
                      : FightClubColors.greyButton,
              child: Center(
                child: Text(
                  isGameOver ? 'Start new game' : 'GO',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      color: FightClubColors.whiteText),
                ),
              ),
            )),
      ),
    );
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
                ColoredBox(
                  color: Colors.green,
                  child: SizedBox(
                    height: 44,
                    width: 44,
                  ),
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
            padding: EdgeInsets.only(bottom: index < overallLivesCount ? 4 : 0),
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
        child: SizedBox(
          height: 40,
          child: ColoredBox(
            color: selected
                ? FightClubColors.blueButton
                : FightClubColors.greyButton,
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
      ),
    );
  }
}
