import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/colors.dart';

class ResButtonStyle {
  final Color bgColor;
  final Color textColor;
  final Color bgDisabled;

  ResButtonStyle._(this.bgColor, this.textColor, this.bgDisabled);

  static final primary = ResButtonStyle._(
      ResColors.BLACK, Color(0xFFFFFFFF), ResColors.GRAY);

  static final secondary = ResButtonStyle._(
      ResColors.PURPLE_LIGHT, ResColors.BLACK, ResColors.PURPLE_LIGHT);
}
