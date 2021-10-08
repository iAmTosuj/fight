part of 'main_page_bloc.dart';

class MainPageState {
  final String? fightResult;

  MainPageState({this.fightResult});

  MainPageState copyWith({String? fightResult}) {
    return MainPageState(fightResult: fightResult ?? this.fightResult);
  }
}
