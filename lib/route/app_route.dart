import 'package:flutter/material.dart';
import 'package:flutter_fight_club/core/models/fooderlich_pages.dart';
import 'package:flutter_fight_club/state/app_state_manager.dart';
import 'package:flutter_fight_club/ui/fight_page/fight_page_provider.dart';
import 'package:flutter_fight_club/ui/main_page/main_page.dart';
import 'package:flutter_fight_club/ui/splash/splash_page.dart';
import 'package:flutter_fight_club/ui/statistic_page/statistics_page.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  // 2
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final AppStateManager appStateManager;

  AppRouter({
    required this.appStateManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        if (!appStateManager.isInitialized) SplashScreen.page(),
        if (appStateManager.isInitialized) MainPage.page(),
        if (appStateManager.isFightActive) FightPageProvider.page(),
        if (appStateManager.isStatisticActive) StatisticsPage.page(),
        // TODO: Add HomeScreed
        // TODO: Add FightScreen
        // TODO: Add StatisticScreen
      ],
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) async => null;

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }

    if (route.settings.name == FooderlichPages.statisticPath) {
      appStateManager.closeStatisticActive();
    } else if (route.settings.name == FooderlichPages.fightPath) {
      appStateManager.closeFightActive();
    }
    // TODO: Handle splash

    return true;
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);

    super.dispose();
  }
}
