import 'package:flutter/cupertino.dart';
import 'package:flutter_fight_club/pages/fight_page.dart';

import '../resourse/fight_club_colors.dart';

class SecondaryActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const SecondaryActionButton(
      {Key? key, required this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(color: FightClubColors.darkGreyText, width: 2)),
        alignment: Alignment.center,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: FightClubColors.darkGreyText),
        ),
      ),
    );
  }
}
