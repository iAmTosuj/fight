part of 'fight_page_bloc.dart';

@immutable
abstract class FightPageEvent {}

@immutable
class FightPageSelectDefend extends FightPageEvent {
  final BodyPart bodyPart;

  FightPageSelectDefend(this.bodyPart);
}

class FightPageSelectAttack extends FightPageEvent {
  final BodyPart bodyPart;

  FightPageSelectAttack(this.bodyPart);
}

class FightPageGo extends FightPageEvent {}

class FightPageResetGame extends FightPageEvent {}
