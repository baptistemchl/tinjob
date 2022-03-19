import 'package:flutter/material.dart';

import 'package:tinjob/screen/about.dart';
import 'package:tinjob/screen/admis.dart';
import 'package:tinjob/screen/candidateDetail.dart';
import 'package:tinjob/screen/map.dart';
import 'package:tinjob/screen/refus.dart';
import 'package:tinjob/screen/settings.dart';
import 'package:tinjob/screen/stats.dart';
import 'package:tinjob/screen/swipe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screen/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Tin-Job',
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/settings': (context) => const SettingsScreen(),
          '/map': (context) => MapScreen(),
          '/swipe': (context) => const SwipeScreen(),
          '/refus': (context) => const RefusScreen(),
          '/admis': (context) => const AdmisScreen(),
          '/about': (context) => AboutScreen(),
          '/stats': (context) => const StatsScreen(),
        },
        theme: ThemeData(
          textTheme: GoogleFonts.playTextTheme(
            Theme.of(context).textTheme,
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
