import 'package:flutter/material.dart';
import 'package:flutter_fight_club/bloc/fight_page/fight_page_bloc.dart';
import 'package:flutter_fight_club/core/body_part.dart';
import 'package:flutter_fight_club/core/route/app_link.dart';
import 'package:flutter_fight_club/core/state/fight_state_manager.dart';
import 'package:flutter_fight_club/resources/button_style_link.dart';
import 'package:flutter_fight_club/ui/fight_page/widgets/controls_widget.dart';
import 'package:flutter_fight_club/ui/fight_page/widgets/fighters_info.dart';
import 'package:flutter_fight_club/ui/fight_page/widgets/info_board.dart';
import 'package:flutter_fight_club/ui/widgets/action_button.dart';
import 'package:provider/provider.dart';

import '../../../resources/colors.dart';

class FightPageProvider extends StatelessWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: AppLink.fightPath,
      key: ValueKey(AppLink.fightPath),
      child: FightPageProvider(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ResColors.PURPLE_LIGHT,
      body: SafeArea(
        child: SizedBox(
          child: Column(
            children: <Widget>[
              Consumer<FightStateManager>(
                builder: (context, state, _) {
                  return FightersInfo(
                    maxLivesCount: maxLives,
                    enemyLivesCount: state.enemyLives,
                    yourLivesCount: state.yourLives,
                  );
                },
              ),
              Expanded(child: Consumer<FightStateManager>(
                builder: (context, state, _) {
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
                child: Consumer<FightStateManager>(
                  builder: (context, state, _) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 14.0),
                          child: ControlsWidget(
                            selectAttackingPart: (BodyPart value) =>
                                _selectAttackingPart(value, state),
                            selectDefendingPart: (BodyPart value) =>
                                _selectDefendingPart(value, state),
                            attackingBodyPart: state.attackingBodyPart,
                            defendingBodyPart: state.defendingBodyPart,
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
                            onTap: () => state.pressGo(context),
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

  void _selectDefendingPart(final BodyPart value, FightStateManager state) {
    if (state.isGameOver()) {
      return;
    }

    state.setDefend(value);
  }

  void _selectAttackingPart(final BodyPart value, FightStateManager state) {
    if (state.isGameOver()) {
      return;
    }

    state.setAttack(value);
  }
}
