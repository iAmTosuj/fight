import 'package:bloc/bloc.dart';
import 'package:flutter_fight_club/core/fight_result.dart';
import 'package:flutter_fight_club/repository/shared_pref_repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'statistic_event.dart';
part 'statistic_state.dart';

class StatisticBloc extends Bloc<StatisticEvent, StatisticState> {
  final SharedPrefRepository _pref = Get.find<SharedPrefRepository>();

  StatisticBloc() : super(StatisticState()) {
    on<StatisticSetStatus>((event, emit) async {
      switch (event.fightResult) {
        case FightResult.draw:
          await _pref.increaseDraw();
          break;
        case FightResult.lost:
          await _pref.increaseLost();
          break;
        case FightResult.won:
          await _pref.increaseWin();
          break;
      }

      await _pref.setFightResult(event.fightResult.result);

      emit(state.copyWith(
          fightResult: _pref.getFightResult(),
          lostCount: _pref.getFightLost(),
          drawCount: _pref.getFightDraw(),
          winCount: _pref.getFightWin()));
    });

    on<StatisticInitBloc>((event, emit) async {
      emit(state.copyWith(
          fightResult: _pref.getFightResult(),
          lostCount: _pref.getFightLost(),
          drawCount: _pref.getFightDraw(),
          winCount: _pref.getFightWin()));
    });
  }
}
