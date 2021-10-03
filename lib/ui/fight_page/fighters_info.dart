import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/colors.dart';
import 'package:flutter_fight_club/resources/images.dart';
import 'package:flutter_fight_club/ui/fight_page/lives_widget.dart';

class FightersInfo extends StatelessWidget {
  final int maxLivesCount;
  final int yourLivesCount;
  final int enemyLivesCount;

  const FightersInfo({
    Key? key,
    required this.maxLivesCount,
    required this.yourLivesCount,
    required this.enemyLivesCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 160,
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: ColoredBox(
                      color: Colors.white,
                    )),
                Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.white,
                            Color.fromRGBO(197, 209, 234, 1)
                          ])),
                    )),
                Expanded(
                    child: ColoredBox(color: Color.fromRGBO(197, 209, 234, 1))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                LivesWidget(
                    overallLivesCount: maxLivesCount,
                    currentLivesCount: yourLivesCount),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text('You',
                          style:
                          TextStyle(color: FightClubColors.darkGreyText)),
                    ),
                    Image.asset(
                      FightClubImages.youAvatar,
                      height: 92,
                      width: 92,
                    )
                  ],
                ),
                SizedBox(
                  height: 44,
                  width: 44,
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: FightClubColors.blueButton),
                      child: Center(
                        child: Text(
                          'vs',
                          style: TextStyle(color: FightClubColors.whiteText),
                        ),
                      )),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text('Enemy',
                          style:
                          TextStyle(color: FightClubColors.darkGreyText)),
                    ),
                    Image.asset(
                      FightClubImages.enemyAvatar,
                      height: 92,
                      width: 92,
                    )
                  ],
                ),
                LivesWidget(
                    overallLivesCount: maxLivesCount,
                    currentLivesCount: enemyLivesCount)
              ],
            ),
          ],
        ));
  }
}