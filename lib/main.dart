import 'package:flutter/material.dart';
import 'package:flutter_fight_club/repository/shared_pref_repository.dart';
import 'package:flutter_fight_club/ui/application.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences _prefs = await SharedPreferences.getInstance();
  SharedPrefRepository _prefsRepository = SharedPrefRepository(_prefs);
  Get.put(_prefsRepository);
  await Future.delayed(Duration(seconds: 5));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Application();
  }
}
