import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fight_club/bloc/fight_page/fight_page_bloc.dart';
import 'package:flutter_fight_club/bloc/main_page/main_page_bloc.dart';
import 'package:flutter_fight_club/repository/shared_pref_repository.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'route/route.dart' as route;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences _prefs = await SharedPreferences.getInstance();
  SharedPrefRepository _prefsRepository = SharedPrefRepository(_prefs);
  Get.put(_prefsRepository);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainPageBloc>(
            create: (_) => MainPageBloc()..add(MainPageInitBloc())),
        BlocProvider<FightPageBloc>(
            create: (context) => FightPageBloc(context.read<MainPageBloc>())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.pressStart2pTextTheme(
              Theme.of(context).textTheme,
            )),
        onGenerateRoute: route.controller,
        initialRoute: route.MAIN_PAGE,
      ),
    );
  }
}
