import 'package:flutter/material.dart';
import 'package:flutter_fight_club/core/body_part.dart';
import 'package:flutter_fight_club/resources/colors.dart';
import 'package:flutter_fight_club/ui/fight_page/body_part_button.dart';

class ControlsWidget extends StatelessWidget {
  final BodyPart? defendingBodyPart;
  final ValueSetter<BodyPart> selectDefendingPart;
  final BodyPart? attackingBodyPart;
  final ValueSetter<BodyPart> selectAttackingPart;

  const ControlsWidget(
      {Key? key,
        required this.defendingBodyPart,
        required this.selectDefendingPart,
        required this.attackingBodyPart,
        required this.selectAttackingPart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 16,
        ),
        Expanded(
            child: Column(
              children: [
                Text('DEFEND',
                    style: TextStyle(color: FightClubColors.darkGreyText)),
                SizedBox(
                  height: 13,
                ),
                BodyPartButton(
                  bodyPart: BodyPart.head,
                  selected: defendingBodyPart == BodyPart.head,
                  bodyPartSetter: selectDefendingPart,
                ),
                BodyPartButton(
                  bodyPart: BodyPart.torso,
                  selected: defendingBodyPart == BodyPart.torso,
                  bodyPartSetter: selectDefendingPart,
                ),
                BodyPartButton(
                  bodyPart: BodyPart.legs,
                  selected: defendingBodyPart == BodyPart.legs,
                  bodyPartSetter: selectDefendingPart,
                ),
              ],
            )),
        SizedBox(
          width: 12,
        ),
        Expanded(
            child: Column(
              children: [
                Text('ATTACK',
                    style: TextStyle(color: FightClubColors.darkGreyText)),
                SizedBox(
                  height: 13,
                ),
                BodyPartButton(
                  bodyPart: BodyPart.head,
                  selected: attackingBodyPart == BodyPart.head,
                  bodyPartSetter: selectAttackingPart,
                ),
                BodyPartButton(
                  bodyPart: BodyPart.torso,
                  selected: attackingBodyPart == BodyPart.torso,
                  bodyPartSetter: selectAttackingPart,
                ),
                BodyPartButton(
                  bodyPart: BodyPart.legs,
                  selected: attackingBodyPart == BodyPart.legs,
                  bodyPartSetter: selectAttackingPart,
                ),
              ],
            )),
        SizedBox(
          width: 16,
        )
      ],
    );
  }
}