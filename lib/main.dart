import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Helpers/ads_helper.dart';
import 'Helpers/pref.dart';
import 'screens/splash.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

late Size mq;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Pref.initializeHive();
  await AdHelper.initAds();
  runApp(MyApp());
}

late SizedBox size;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Enqueue Vpn ',
      theme:
          ThemeData(appBarTheme: AppBarTheme(centerTitle: true, elevation: 3)),

      themeMode:Pref.isDarkMode?ThemeMode.dark:ThemeMode.light,

      darkTheme:

          ThemeData(
             brightness: Brightness.dark,
              appBarTheme: AppBarTheme(centerTitle: true, elevation: 3)),
      home: SplashScreen(),
    );
  }
}
extension AppTheme on ThemeData{
  Color get lightTest => Pref.isDarkMode ? Colors.white70 : Colors.black54;
  Color get bottomNav => Pref.isDarkMode ? Colors.white12 : Colors.blue;
}
