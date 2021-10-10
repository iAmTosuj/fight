import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fight_club/bloc/main_page/main_page_bloc.dart';
import 'package:flutter_fight_club/resources/button_style.dart';
import 'package:flutter_fight_club/resources/colors.dart';
import 'package:flutter_fight_club/route/route.dart' as route;
import 'package:flutter_fight_club/ui/widgets/action_button.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _MainPageContent();
  }
}

class _MainPageContent extends StatelessWidget {
  _MainPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Center(
                child: Text(
                  'The\nFight\nClub'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30, color: FightClubColors.darkGreyText),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
            BlocBuilder<MainPageBloc, MainPageState>(builder: (context, state) {
              if (state.fightResult == null) {
                return const SizedBox();
              }

              return Center(
                child: Text(state.fightResult!),
              );
            }),
            Expanded(
              child: SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ActionButton(
                text: 'STATISTICS',
                color: ResButtonStyle.secondary,
                border: true,
                onTap: () => Navigator.pushNamed(context, route.STATISTIC_PAGE),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ActionButton(
                text: 'Start'.toUpperCase(),
                color: ResButtonStyle.primary,
                onTap: () => Navigator.pushNamed(context, route.FIGHT_PAGE),
              ),
            )
          ],
        ),
      ),
    );
  }
}
