import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              padding: EdgeInsets.only(bottom: 16),
              child: SecondaryActionButton(
                  onTap: () => Navigator.of(context).pop(), text: 'Back'),
            )
          ],
        ),
      ),
    );
  }
}
