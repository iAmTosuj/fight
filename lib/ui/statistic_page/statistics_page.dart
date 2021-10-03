import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/button_style.dart';
import 'package:flutter_fight_club/resources/colors.dart';
import 'package:flutter_fight_club/ui/widgets/action_button.dart';

class StatisticsPage extends StatelessWidget {
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
            Expanded(child: SizedBox()),
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
