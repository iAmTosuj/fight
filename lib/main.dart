import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fight_club/bloc/fight_page/fight_page_bloc.dart';
import 'package:flutter_fight_club/bloc/main_page/main_page_bloc.dart';
import 'package:flutter_fight_club/repository/shared_pref_repository.dart';
import 'package:flutter_fight_club/route/app_route.dart';
import 'package:flutter_fight_club/state/app_state_manager.dart';
import 'package:flutter_fight_club/state/fight_state_manager.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences _prefs = await SharedPreferences.getInstance();
  SharedPrefRepository _prefsRepository = SharedPrefRepository(_prefs);
  Get.put(_prefsRepository);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appStateManager = AppStateManager();
  final _fightStateManager = FightStateManager();
  late AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      fightStateManager: _fightStateManager,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainPageBloc>(
            create: (_) => MainPageBloc()..add(MainPageInitBloc())),
        BlocProvider<FightPageBloc>(
            create: (context) => FightPageBloc(context.read<MainPageBloc>())),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<AppStateManager>(
              create: (context) => _appStateManager),
          ChangeNotifierProvider<FightStateManager>(
              create: (context) => _fightStateManager),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: GoogleFonts.pressStart2pTextTheme(
                Theme.of(context).textTheme,
              )),
          home: Router(
            routerDelegate: _appRouter,
          ),
        ),
      ),
    );
  }
}
