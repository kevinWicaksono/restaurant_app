import 'package:flutter/material.dart';
import 'package:restaurant_app/Pages/pg_home.dart';
import 'package:restaurant_app/Styling/text_theme.dart';
import 'package:restaurant_app/Widgets/wg_splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: myTextTheme,
        // useMaterial3: true,
        scaffoldBackgroundColor: Colors.deepPurple[50],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple[700],
          titleTextStyle: myTextTheme.titleMedium!.copyWith(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        primaryColor: Colors.deepPurple,
      ),
      initialRoute: Splash.routeName,
      routes: {
        Splash.routeName: (context) => const Splash(),
        PgHome.routeName: (context) => const PgHome(),
      },
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return WgSplashScreen(
      appName: 'Dicoding Restaurant App',
      imgSplash: Image.asset('assets/dicoding_logo.png'),
      splashDuration: 3,
      afterSplash: PgHome.routeName,
    );
  }
}
