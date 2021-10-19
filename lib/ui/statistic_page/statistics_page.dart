import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fight_club/bloc/main_page/main_page_bloc.dart';
import 'package:flutter_fight_club/resources/button_style.dart';
import 'package:flutter_fight_club/resources/colors.dart';
import 'package:flutter_fight_club/route/fooderlich_pages.dart';
import 'package:flutter_fight_club/ui/widgets/action_button.dart';

class StatisticsPage extends StatelessWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: AppLink.statisticPath,
      key: ValueKey(AppLink.statisticPath),
      child: StatisticsPage(),
    );
  }

  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 24),
              child: Text(
                'Statistics',
                style: TextStyle(
                  color: FightClubColors.darkGreyText,
                  fontSize: 24,
                ),
              ),
            ),
            Expanded(child: BlocBuilder<MainPageBloc, MainPageState>(
              builder: (context, state) {
                return state.winCount != null &&
                        state.drawCount != null &&
                        state.lostCount != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Won:'),
                                  Text(state.winCount.toString())
                                ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Draw:'),
                                  Text(state.drawCount.toString())
                                ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Lost:'),
                                  Text(state.lostCount.toString())
                                ]),
                          ),
                        ],
                      )
                    : SizedBox();
              },
            )),
            Padding(
              padding: EdgeInsets.all(8),
              child: ActionButton(
                onTap: () => Navigator.of(context).pop(),
                text: 'Back',
                color: ResButtonStyle.secondary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
