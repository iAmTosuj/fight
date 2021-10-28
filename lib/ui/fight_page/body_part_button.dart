import 'package:flutter/material.dart';
import 'package:flutter_fight_club/core/body_part.dart';
import 'package:flutter_fight_club/resources/colors.dart';

class BodyPartButton extends StatelessWidget {
  final BodyPart bodyPart;
  final bool selected;
  final ValueSetter<BodyPart> bodyPartSetter;

  const BodyPartButton(
      {Key? key,
      required this.bodyPart,
      required this.selected,
      required this.bodyPartSetter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => bodyPartSetter(bodyPart),
      splashColor: ResColors.BLUE,
      child: SizedBox(
        height: 40,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: selected ? ResColors.BLUE : Colors.transparent,
              border: !selected
                  ? Border.all(color: ResColors.DARK_GREY, width: 2)
                  : null),
          child: Center(
            child: Text(
              bodyPart.name.toUpperCase(),
              style: TextStyle(
                  color:
                      selected ? ResColors.WHITE : ResColors.DARK_GREY),
            ),
          ),
        ),
      ),
    );
  }
}
