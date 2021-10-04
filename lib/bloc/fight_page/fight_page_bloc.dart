import 'package:bloc/bloc.dart';
import 'package:flutter_fight_club/core/body_part.dart';
import 'package:meta/meta.dart';

part 'fight_page_event.dart';
part 'fight_page_state.dart';

class FightPageBloc extends Bloc<FightPageEvent, FightPageState> {
  FightPageBloc() : super(FightPageState()) {
    on<FightPageSelectDefend>((event, emit) {
      // TODO: implement event handler
    });

    on<FightPageSelectAttack>((event, emit) {
      // TODO: implement event handler
    });
  }
}
