import 'package:bloc/bloc.dart';
import 'package:flutter_fight_club/repository/shared_pref_repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  MainPageBloc() : super(MainPageState()) {
    on<MainPageSetWinner>((event, emit) async {
      if (event.fightResult != null) {
        await Get.find<SharedPrefRepository>()
            .serFightResult(event.fightResult!);
      }

      emit(state.copyWith(fightResult: event.fightResult));
    });
  }
}
