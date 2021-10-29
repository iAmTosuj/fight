part of 'statistic_bloc.dart';

class StatisticState {
  final String? fightResult;
  final bool isInit;
  final int? winCount;
  final int? lostCount;
  final int? drawCount;

  StatisticState({
    this.fightResult,
    this.winCount,
    this.isInit = false,
    this.lostCount,
    this.drawCount,
  });

  StatisticState copyWith(
      {String? fightResult, int? winCount, int? lostCount, int? drawCount}) {
    return StatisticState(
        fightResult: fightResult ?? this.fightResult,
        winCount: winCount ?? this.winCount,
        lostCount: lostCount ?? this.lostCount,
        isInit: true,
        drawCount: drawCount ?? drawCount);
  }
}
