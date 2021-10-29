import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fight_club/bloc/fight_page/fight_page_bloc.dart';
import 'package:flutter_fight_club/core/body_part.dart';
import 'package:flutter_fight_club/resources/button_style.dart';
import 'package:flutter_fight_club/ui/fight_page/widgets/controls_widget.dart';
import 'package:flutter_fight_club/ui/fight_page/widgets/fighters_info.dart';
import 'package:flutter_fight_club/ui/fight_page/widgets/info_board.dart';
import 'package:flutter_fight_club/ui/widgets/action_button.dart';

import '../../resources/colors.dart';

class FightPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = context.read<FightPageBloc>();

    return Scaffold(
      backgroundColor: ResColors.PURPLE_LIGHT,
      body: SafeArea(
        child: SizedBox(
          child: Column(
            children: <Widget>[
              BlocBuilder<FightPageBloc, FightPageState>(
                buildWhen: (prev, state) {
                  return prev.yourLives != state.yourLives ||
                      prev.enemyLives != state.enemyLives;
                },
                builder: (context, state) {
                  return FightersInfo(
                    maxLivesCount: maxLives,
                    enemyLivesCount: state.enemyLives,
                    yourLivesCount: state.yourLives,
                  );
                },
              ),
              Expanded(
                  child: BlocBuilder<FightPageBloc, FightPageState>(
                buildWhen: (prev, state) {
                  return prev.enemyFightInfoText != state.enemyFightInfoText ||
                      prev.youFightInfoText != state.youFightInfoText ||
                      prev.gameOverText != state.gameOverText;
                },
                builder: (context, state) {
                  return Padding(
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
                  );
                },
              )),
              Expanded(
                child: BlocBuilder<FightPageBloc, FightPageState>(
                  buildWhen: (prev, state) {
                    return prev.attackingBodyPart != state.attackingBodyPart ||
                        prev.defendingBodyPart != state.defendingBodyPart ||
                        prev.gameOverText != state.gameOverText;
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 14.0),
                          child: ControlsWidget(
                            selectAttackingPart: (BodyPart value) =>
                                _selectAttackingPart(value, bloc),
                            selectDefendingPart: (BodyPart value) =>
                                _selectDefendingPart(value, bloc),
                            attackingBodyPart: bloc.state.attackingBodyPart,
                            defendingBodyPart: bloc.state.defendingBodyPart,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 16.0),
                          child: ActionButton(
                            text: state.isGameOver() ? 'Start new game' : 'GO',
                            color: ResButtonStyle.primary,
                            disabled: !state.isGameOver() &&
                                !state.isAllBtnSelected(),
                            onTap: () => _onGoButtonClicked(context, bloc),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onGoButtonClicked(BuildContext context, FightPageBloc bloc) {
    if (!bloc.state.isAllBtnSelected() && !bloc.state.isGameOver()) {
      return;
    }

    if (bloc.state.isGameOver()) {
      bloc.add(FightPageResetGame());

      Navigator.of(context).pop();

      return;
    }

    bloc.add(FightPageGo());
  }

  void _selectDefendingPart(final BodyPart value, FightPageBloc bloc) {
    if (bloc.state.isGameOver()) {
      return;
    }

    bloc.add(FightPageSelectDefend(value));
  }

  void _selectAttackingPart(final BodyPart value, FightPageBloc bloc) {
    if (bloc.state.isGameOver()) {
      return;
    }

    bloc.add(FightPageSelectAttack(value));
  }
}
