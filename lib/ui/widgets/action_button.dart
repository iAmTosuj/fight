import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/button_style.dart';
import 'package:flutter_fight_club/resources/colors.dart';

class ActionButton extends StatelessWidget {
  final ResButtonStyle color;
  final String text;
  final VoidCallback onTap;
  final bool border;
  final bool disabled;

  const ActionButton(
      {Key? key,
      required this.onTap,
      required this.text,
      required this.color,
      this.border = false,
      this.disabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: FightClubColors.darkGreyText, width: 2),
            color: disabled ? color.bgDisabled : color.bgColor,
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: color.textColor),
          ),
        ),
      ),
    );
  }
}
