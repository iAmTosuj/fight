part of 'main_page_bloc.dart';

@immutable
abstract class MainPageEvent {}

class MainPageSetStatus extends MainPageEvent {
  final FightResult fightResult;

  MainPageSetStatus(this.fightResult);
}

class MainPageInitBloc extends MainPageEvent {}
