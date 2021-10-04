import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fight_club/bloc/fight_page/fight_page_bloc.dart';
import 'package:flutter_fight_club/core/body_part.dart';
import 'package:flutter_fight_club/resources/button_style.dart';
import 'package:flutter_fight_club/ui/fight_page/controls_widget.dart';
import 'package:flutter_fight_club/ui/fight_page/fighters_info.dart';
import 'package:flutter_fight_club/ui/fight_page/info_board.dart';
import 'package:flutter_fight_club/ui/widgets/action_button.dart';

import '../../resources/colors.dart';

class FightPage extends StatelessWidget {
  // static const maxLives = 5;
  // BodyPart? defendingBodyPart;
  // BodyPart? attackingBodyPart;
  // int yourLives = maxLives;
  // int enemysLives = maxLives;
  // String youFightInfoText = '';
  // String enemyFightInfoText = '';
  // String gameOverText = '';
  // BodyPart whatEnemyAttacks = BodyPart.random();
  // BodyPart whatEnemyDefends = BodyPart.random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: BlocBuilder<FightPageBloc, FightPageState>(
          builder: (context, state) {
            return SizedBox(
              child: Column(
                children: <Widget>[
                  FightersInfo(
                    maxLivesCount: maxLives,
                    enemyLivesCount: state.enemyLives,
                    yourLivesCount: state.yourLives,
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
                            enemyText: state.enemyFightInfoText,
                            youText: state.youFightInfoText,
                            gameOverText: state.gameOverText,
                          ),
                        )),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 14.0),
                    child: ControlsWidget(
                      selectAttackingPart: _selectAttackingPart,
                      selectDefendingPart: _selectDefendingPart,
                      attackingBodyPart: state.attackingBodyPart,
                      defendingBodyPart: state.defendingBodyPart,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 16.0),
                    child: ActionButton(
                      text: _isGameOver(state) ? 'Start new game' : 'GO',
                      color: ResButtonStyle.primary,
                      disabled:
                          !_isGameOver(state) && !_isAllBtnSelected(state),
                      onTap: () => _onGoButtonClicked(context, state),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _onGoButtonClicked(BuildContext context, FightPageState state) {
    // if (!_isAllBtnSelected() && !_isGameOver()) {
    //   return;
    // }
    //
    // if (_isGameOver()) {
    //   // setState(() {
    //   //   gameOverText = '';
    //   //   youFightInfoText = '';
    //   //   enemyFightInfoText = '';
    //   //   enemysLives = maxLives;
    //   //   yourLives = maxLives;
    //   // });
    //
    //   Navigator.of(context).pop();
    //
    //   return;
    // }

    final bool enemyLoseLife =
        state.attackingBodyPart != state.whatEnemyDefends;
    final bool youLoseLife = state.defendingBodyPart != state.whatEnemyAttacks;

    // setState(() {
    //   youFightInfoText = 'Your attack was blocked.';
    //   enemyFightInfoText = 'Enemy’s attack was blocked.';
    //
    //   if (enemyLoseLife) {
    //     enemysLives -= 1;
    //     youFightInfoText = 'Your hit enemy ${attackingBodyPart!.name}.';
    //   }
    //
    //   if (youLoseLife) {
    //     yourLives -= 1;
    //     enemyFightInfoText = 'Enemy hit your ${whatEnemyAttacks.name}.';
    //   }
    //
    //   final FightResult? fightResult =
    //       FightResult.calculateResult(yourLives, enemysLives);
    //   if (fightResult != null) {
    //     gameOverText = fightResult.result;
    //
    //     SharedPreferences.getInstance().then((sharedPreferences) =>
    //         sharedPreferences.setString(
    //             'last_fight_result', fightResult.result));
    //   }
    //
    //   whatEnemyAttacks = BodyPart.random();
    //   whatEnemyDefends = BodyPart.random();
    //
    //   defendingBodyPart = null;
    //   attackingBodyPart = null;
    // });
  }

  bool _isAllBtnSelected(FightPageState state) {
    return !(state.defendingBodyPart == null ||
        state.attackingBodyPart == null);
  }

  bool _isGameOver(FightPageState state) {
    return (state.yourLives == 0 || state.enemyLives == 0);
  }

  void _selectDefendingPart(final BodyPart value) {
    // if (_isGameOver()) {
    //   return;
    // }

    // setState(() {
    //   defendingBodyPart = value;
    // });
  }

  void _selectAttackingPart(final BodyPart value) {
    // if (_isGameOver()) {
    //   return;
    // }

    // setState(() {
    //   attackingBodyPart = value;
    // });
  }
}
