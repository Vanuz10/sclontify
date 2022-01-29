import 'package:flutter/material.dart';
import 'package:spotify/pages/login_page.dart';
import 'package:spotify/pages/menu_page.dart';
import 'package:spotify/pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        accentColor: Colors.greenAccent
      ),
      title: 'Spotify',
      initialRoute: 'splash',
      routes: {
        'login':(BuildContext context) => const LoginPage(),
        'menu':(BuildContext context) => const MenuPage(),
        'splash':(BuildContext context) => const SplashScreenPage(),
      },
    );
  }
}