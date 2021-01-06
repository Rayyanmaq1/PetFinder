import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pet_finder/Screens/Authentication/Login.dart';
import 'package:pet_finder/Screens/BottomNavigationBar/CustomNavigation.dart';
import 'Screens/BottomNavigationBar/CustomNavigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: {
        '/home': (context) => CustomNavigation(),
        '/Login': (context) => Login(),
      },
      debugShowCheckedModeBanner: false,
      home: CustomNavigation(),
    );
  }
}
