import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/colors.dart';

class ResButtonStyle {
  final Color bgColor;
  final Color textColor;
  final Color bgDisabled;

  ResButtonStyle._(this.bgColor, this.textColor, this.bgDisabled);

  static final primary = ResButtonStyle._(FightClubColors.blackButton,
      Color(0xFFFFFFFF), FightClubColors.greyButton);

  static final secondary = ResButtonStyle._(FightClubColors.background,
      FightClubColors.blackButton, FightClubColors.background);
}
