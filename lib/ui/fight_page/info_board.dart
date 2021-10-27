import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/colors.dart';

class InfoBoard extends StatelessWidget {
  final String enemyText;
  final String youText;
  final String gameOverText;

  const InfoBoard(
      {Key? key,
      required this.enemyText,
      required this.youText,
      required this.gameOverText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      getActualText(),
      style: TextStyle(
        fontSize: 10,
        color: ResColors.darkGreyText,
      ),
      textAlign: TextAlign.center,
    ));
  }

  String getActualText() {
    if (gameOverText.length != 0) {
      return gameOverText;
    }

    if (youText.length != 0 && enemyText.length != 0) {
      return '$youText\n$enemyText';
    }

    return '';
  }
}
