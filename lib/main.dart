import 'package:flutter/material.dart';
import 'package:flutter_fight_club/ui/fight_page/fight_page.dart';
import 'package:flutter_fight_club/ui/main_page/main_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.pressStart2pTextTheme(
            Theme.of(context).textTheme,
          )),
      home: MainPage(),
    );
  }
}
