import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/icons.dart';

class LivesWidget extends StatelessWidget {
  final int overallLivesCount;
  final int currentLivesCount;

  const LivesWidget(
      {Key? key,
        required this.overallLivesCount,
        required this.currentLivesCount})
      : assert(overallLivesCount >= 1),
        assert(currentLivesCount >= 0),
        assert(currentLivesCount <= overallLivesCount),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(overallLivesCount, (index) {
        return Padding(
            padding:
            EdgeInsets.only(bottom: index < overallLivesCount - 1 ? 4 : 0),
            child: Image.asset(
              index < currentLivesCount
                  ? FightClubIcons.HeartFull
                  : FightClubIcons.HeartEmpty,
              width: 18,
              height: 18,
            ));
      }),
    );
  }
}