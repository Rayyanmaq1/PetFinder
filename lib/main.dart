import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pet_finder/Screens/Authentication/Login.dart';
import 'package:pet_finder/Screens/BottomNavigationBar/CustomNavigation.dart';
import 'package:pet_finder/ViewModel/SizeConfig.dart';
import 'Screens/BottomNavigationBar/CustomNavigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // ignore: missing_return
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        return GetMaterialApp(
          routes: {
            '/home': (context) => CustomNavigation(),
            '/Login': (context) => Login(),
          },
          debugShowCheckedModeBanner: false,
          home: CustomNavigation(),
        );
      });
    });
  }
}
