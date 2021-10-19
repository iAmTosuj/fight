import 'package:flutter/material.dart';
import 'package:flutter_fight_club/route/app_link.dart';
import 'package:flutter_fight_club/state/app_state_manager.dart';
import 'package:flutter_fight_club/ui/fight_page/fight_page_provider.dart';
import 'package:flutter_fight_club/ui/main_page/main_page.dart';
import 'package:flutter_fight_club/ui/splash/splash_page.dart';
import 'package:flutter_fight_club/ui/statistic_page/statistics_page.dart';

class AppRouter extends RouterDelegate<AppLink>
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
        if (appStateManager.isInitialized) ...[
          MainPage.page(),
          if (appStateManager.isFightActive) FightPageProvider.page(),
          if (appStateManager.isStatisticActive) StatisticsPage.page(),
        ]
        // TODO: Add HomeScreed
        // TODO: Add FightScreen
        // TODO: Add StatisticScreen
      ],
    );
  }

  @override
  AppLink get currentConfiguration => getCurrentPath();

  AppLink getCurrentPath() {
    if (appStateManager.isFightActive) {
      return AppLink(location: AppLink.fightPath);
    } else if (appStateManager.isStatisticActive) {
      return AppLink(location: AppLink.statisticPath);
    } else {
      return AppLink(location: AppLink.home);
    }
  }

  @override
  Future<void> setNewRoutePath(AppLink newLink) async {
    switch (newLink.location) {
      case AppLink.fightPath:
        appStateManager.closeStatisticActive();
        appStateManager.setFightActive();

        break;
      case AppLink.statisticPath:
        appStateManager.closeFightActive();
        appStateManager.setFightActive();
        break;
      case AppLink.home:
        appStateManager.closeFightActive();
        appStateManager.closeStatisticActive();
        break;
      default:
        break;
    }
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }

    if (route.settings.name == AppLink.statisticPath) {
      appStateManager.closeStatisticActive();
    } else if (route.settings.name == AppLink.fightPath) {
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
