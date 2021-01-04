import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet_finder/Screens/BottomNavigationBar/CustomNavigation.dart';
import 'Screens/BottomNavigationBar/CustomNavigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  PageController controller;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => CustomNavigation(),
      },
      debugShowCheckedModeBanner: false,
      home: CustomNavigation(),
    );
  }
}
