part of 'main_page_bloc.dart';

@immutable
abstract class MainPageEvent {}

class MainPageSetWinner extends MainPageEvent {
  final String? fightResult;

  MainPageSetWinner(this.fightResult);
}
