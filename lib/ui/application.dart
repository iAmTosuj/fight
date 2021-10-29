import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fight_club/bloc/fight_page/fight_page_bloc.dart';
import 'package:flutter_fight_club/bloc/statistic/statistic_bloc.dart';
import 'package:flutter_fight_club/core/route/app_route.dart';
import 'package:flutter_fight_club/core/route/app_route_parser.dart';
import 'package:flutter_fight_club/core/state/app_state_manager.dart';
import 'package:flutter_fight_club/core/state/fight_state_managte_parser.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Application extends StatefulWidget {
  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final _appStateManager = AppStateManager();
  final _mainPageBloc = StatisticBloc();
  late FightStateManager _fightStateManager;
  late AppRouter _appRouter;
  final AppRouteParser _appRouteParser = AppRouteParser();
  @override
  void initState() {
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
    );

    _fightStateManager = FightStateManager(_mainPageBloc);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StatisticBloc>(
            create: (_) => _mainPageBloc..add(StatisticInitBloc())),
        BlocProvider<FightPageBloc>(
            create: (context) => FightPageBloc(context.read<StatisticBloc>())),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<AppStateManager>(
              create: (context) => _appStateManager),
          ChangeNotifierProvider<FightStateManager>(
              create: (context) => _fightStateManager),
        ],
        child: MaterialApp.router(
          title: 'Flutter Fight Club',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: GoogleFonts.pressStart2pTextTheme(
                Theme.of(context).textTheme,
              )),
          routerDelegate: _appRouter,
          routeInformationParser: _appRouteParser,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
