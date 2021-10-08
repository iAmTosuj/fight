import 'package:bloc/bloc.dart';
import 'package:flutter_fight_club/bloc/main_page/main_page_bloc.dart';
import 'package:flutter_fight_club/core/body_part.dart';
import 'package:flutter_fight_club/core/fight_result.dart';
import 'package:meta/meta.dart';

part 'fight_page_event.dart';
part 'fight_page_state.dart';

class FightPageBloc extends Bloc<FightPageEvent, FightPageState> {
  final MainPageBloc _mainPageBloc;

  FightPageBloc(this._mainPageBloc)
      : super(FightPageState(
            whatEnemyDefends: BodyPart.random(),
            whatEnemyAttacks: BodyPart.random())) {
    on<FightPageSelectDefend>((event, emit) {
      emit(state.copyWith(defendingBodyPart: event.bodyPart));
    });

    on<FightPageSelectAttack>((event, emit) {
      emit(state.copyWith(attackingBodyPart: event.bodyPart));
    });

    on<FightPageResetGame>((event, emit) {
      emit(state.clearState());
    });

    on<FightPageGo>((event, emit) {
      final bool enemyLoseLife =
          state.attackingBodyPart != state.whatEnemyDefends;
      final bool youLoseLife =
          state.defendingBodyPart != state.whatEnemyAttacks;
      var enemyLives = state.enemyLives;
      var yourLives = state.yourLives;
      var gameOverText = '';
      var youFightInfoText = 'Your attack was blocked.';
      var enemyFightInfoText = 'Enemy’s attack was blocked.';

      if (enemyLoseLife) {
        enemyLives -= 1;
        youFightInfoText = 'Your hit enemy ${state.attackingBodyPart!.name}.';
      }

      if (youLoseLife) {
        yourLives -= 1;
        enemyFightInfoText = 'Enemy hit your ${state.whatEnemyAttacks!.name}.';
      }

      final FightResult? fightResult =
          FightResult.calculateResult(yourLives, enemyLives);

      if (fightResult != null) {
        gameOverText = fightResult.result;
        _mainPageBloc.add(MainPageSetWinner(fightResult.result));
      }

      emit(state.nextRound(
        enemyFightInfoText: enemyFightInfoText,
        youFightInfoText: youFightInfoText,
        yourLives: yourLives,
        enemyLives: enemyLives,
        gameOverText: gameOverText,
      ));
    });
  }
}
