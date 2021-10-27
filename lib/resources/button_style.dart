import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/colors.dart';

class ResButtonStyle {
  final Color bgColor;
  final Color textColor;
  final Color bgDisabled;

  ResButtonStyle._(this.bgColor, this.textColor, this.bgDisabled);

  static final primary = ResButtonStyle._(
      ResColors.blackButton, Color(0xFFFFFFFF), ResColors.greyButton);

  static final secondary = ResButtonStyle._(
      ResColors.background, ResColors.blackButton, ResColors.background);
}
