import 'package:flutter/material.dart';
import 'package:urdudatasetcollection/thankyou/thankyouscreen.dart';
import 'package:urdudatasetcollection/welcomescreen/welcomescreen.dart';

import 'drawing/drawingscreen.dart';
import 'form/formscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/Writing Screen': (context) => DrawingScreen(), // Route to Writing Screen
        '/Thanks': (context) => ThankyouScreen(), // Route to Writing Screen
        '/FormScreen': (context) => FormScreen(), // Route to Writing Screen
      },

      home: WelcomeScreen(),
    );
  }
}