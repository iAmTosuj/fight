import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  MainPageBloc() : super(MainPageState()) {
    on<MainPageSetWinner>((event, emit) async {
      if (event.fightResult != null) {
        await Get.find<SharedPreferences>()
            .setString('last_fight_result', event.fightResult!);
      }

      emit(state.copyWith(fightResult: event.fightResult));
    });
  }
}
