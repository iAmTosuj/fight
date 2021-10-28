import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fight_club/bloc/main_page/main_page_bloc.dart';
import 'package:flutter_fight_club/resources/button_style.dart';
import 'package:flutter_fight_club/resources/colors.dart';
import 'package:flutter_fight_club/resources/images.dart';
import 'package:flutter_fight_club/route/app_link.dart';
import 'package:flutter_fight_club/state/app_state_manager.dart';
import 'package:flutter_fight_club/ui/widgets/action_button.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: AppLink.home,
      key: ValueKey(AppLink.home),
      child: MainPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ResColors.PURPLE_LIGHT,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Center(
                child: Text(
                  'The\nFight\nClub'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, color: ResColors.DARK_GREY),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
            BlocBuilder<MainPageBloc, MainPageState>(builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                height: 150,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(color: ResColors.WHITE),
                        ),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                            Colors.white,
                            Color.fromRGBO(197, 209, 234, 1)
                          ])),
                        )),
                        Expanded(
                          child: Container(color: ResColors.DARK_PURPLE),
                        ),
                      ],
                    ),
                    AnimatedPositioned(
                      right: state.isInit ? 50 : 0,
                      duration: Duration(milliseconds: 800),
                      child: Column(
                        children: [
                          Text('you'),
                          Image.asset(
                            FightClubImages.youAvatar,
                            height: 92,
                            width: 92,
                          )
                        ],
                      ),
                    ),
                    AnimatedOpacity(
                      duration: Duration(microseconds: 800),
                      opacity: state.isInit ? 1.0 : 0.0,
                      child: Center(
                        child: Container(
                          height: 44,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(100, 70)),
                              color: ResColors.BLUE),
                          child: Center(
                            child: Text(
                              state.fightResult ?? '',
                              style: TextStyle(color: ResColors.WHITE),
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      left: state.isInit ? 50 : 0,
                      duration: Duration(milliseconds: 800),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Text('enemy'),
                              Image.asset(
                                FightClubImages.enemyAvatar,
                                height: 92,
                                width: 92,
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
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
                onTap: () =>
                    Provider.of<AppStateManager>(context, listen: false)
                        .setStatisticActive(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ActionButton(
                text: 'Start'.toUpperCase(),
                color: ResButtonStyle.primary,
                onTap: () =>
                    Provider.of<AppStateManager>(context, listen: false)
                        .setFightActive(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
