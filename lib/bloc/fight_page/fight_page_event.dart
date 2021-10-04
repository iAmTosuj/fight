part of 'fight_page_bloc.dart';

@immutable
abstract class FightPageEvent {}

@immutable
abstract class FightPageSelectDefend extends FightPageEvent {}

abstract class FightPageSelectAttack extends FightPageEvent {}
