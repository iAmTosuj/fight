part of 'statistic_bloc.dart';

@immutable
abstract class StatisticEvent {}

class StatisticSetStatus extends StatisticEvent {
  final FightResult fightResult;

  StatisticSetStatus(this.fightResult);
}

class StatisticInitBloc extends StatisticEvent {}
