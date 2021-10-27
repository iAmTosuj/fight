part of 'main_page_bloc.dart';

class MainPageState {
  final String? fightResult;
  final bool isInit;
  final int? winCount;
  final int? lostCount;
  final int? drawCount;

  MainPageState({
    this.fightResult,
    this.winCount,
    this.isInit = false,
    this.lostCount,
    this.drawCount,
  });

  MainPageState copyWith(
      {String? fightResult, int? winCount, int? lostCount, int? drawCount}) {
    return MainPageState(
        fightResult: fightResult ?? this.fightResult,
        winCount: winCount ?? this.winCount,
        lostCount: lostCount ?? this.lostCount,
        isInit: true,
        drawCount: drawCount ?? drawCount);
  }
}
