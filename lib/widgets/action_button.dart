import 'package:flutter/cupertino.dart';
import 'package:flutter_fight_club/pages/fight_page.dart';

import '../resourses/fight_club_colors.dart';

class ActionButton extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback onTap;

  const ActionButton(
      {Key? key, required this.onTap, required this.text, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 40,
        color: color,
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: FightClubColors.whiteText),
        ),
      ),
    );
  }
}
