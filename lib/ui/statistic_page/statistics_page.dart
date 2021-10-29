import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fight_club/bloc/statistic/statistic_bloc.dart';
import 'package:flutter_fight_club/resources/button_style.dart';
import 'package:flutter_fight_club/resources/colors.dart';
import 'package:flutter_fight_club/core/route/app_link.dart';
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
      backgroundColor: ResColors.PURPLE_LIGHT,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 24),
              child: Text(
                'Statistics',
                style: TextStyle(
                  color: ResColors.DARK_GREY,
                  fontSize: 24,
                ),
              ),
            ),
            Expanded(child: BlocBuilder<StatisticBloc, StatisticState>(
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
