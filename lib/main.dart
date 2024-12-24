import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:urdudatasetcollection/firebase_options.dart';
import 'package:urdudatasetcollection/form/formscreen_compact.dart';
import 'package:urdudatasetcollection/welcomescreen/welcomescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures binding is initialized
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform); // Initializes Firebase
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
        '/FormScreen': (context) =>
            const CompactFormScreen(), // Route to Writing Screen
      },
      home: const WelcomeScreen(),
    );
  }
}
