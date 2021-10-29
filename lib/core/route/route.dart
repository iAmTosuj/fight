import 'package:flutter/material.dart';
import 'package:flutter_fight_club/ui/fight_page/fight_page.dart';
import 'package:flutter_fight_club/ui/main_page/main_page.dart';
import 'package:flutter_fight_club/ui/statistic_page/statistics_page.dart';

const String MAIN_PAGE = 'main';
const String FIGHT_PAGE = 'fight';
const String STATISTIC_PAGE = 'statistic';

Route<dynamic> controller(RouteSettings setting) {
  switch (setting.name) {
    case MAIN_PAGE:
      return MaterialPageRoute(builder: (context) => MainPage());
    case FIGHT_PAGE:
      return MaterialPageRoute(builder: (context) => FightPage());
    case STATISTIC_PAGE:
      return MaterialPageRoute(builder: (context) => StatisticsPage());
    default:
      return MaterialPageRoute(builder: (context) => MainPage());
  }
}
