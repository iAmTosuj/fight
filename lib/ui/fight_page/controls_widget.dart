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
        Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text('Defend'.toUpperCase(),
                        style: TextStyle(color: FightClubColors.darkGreyText)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14.0),
                    child: BodyPartButton(
                      bodyPart: BodyPart.head,
                      selected: defendingBodyPart == BodyPart.head,
                      bodyPartSetter: selectDefendingPart,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14.0),
                    child: BodyPartButton(
                      bodyPart: BodyPart.torso,
                      selected: defendingBodyPart == BodyPart.torso,
                      bodyPartSetter: selectDefendingPart,
                    ),
                  ),
                  BodyPartButton(
                    bodyPart: BodyPart.legs,
                    selected: defendingBodyPart == BodyPart.legs,
                    bodyPartSetter: selectDefendingPart,
                  ),
                ],
              ),
            )),
        Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text('Attack'.toUpperCase(),
                      style: TextStyle(color: FightClubColors.darkGreyText)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 14.0),
                  child: BodyPartButton(
                    bodyPart: BodyPart.head,
                    selected: attackingBodyPart == BodyPart.head,
                    bodyPartSetter: selectAttackingPart,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 14.0),
                  child: BodyPartButton(
                    bodyPart: BodyPart.torso,
                    selected: attackingBodyPart == BodyPart.torso,
                    bodyPartSetter: selectAttackingPart,
                  ),
                ),
                BodyPartButton(
                  bodyPart: BodyPart.legs,
                  selected: attackingBodyPart == BodyPart.legs,
                  bodyPartSetter: selectAttackingPart,
                ),
              ],
            )),
      ],
    );
  }
}