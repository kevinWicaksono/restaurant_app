import 'package:flutter/material.dart';
import 'package:restaurant_app/Pages/pg_detail.dart';
import 'package:restaurant_app/Pages/pg_home.dart';
import 'package:restaurant_app/Styling/text_theme.dart';
import 'package:restaurant_app/ViewModels/vm_restaurants.dart';
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
        colorScheme: ColorScheme.light(
          primary: const Color(0xFFa32600),
          surface: const Color(0xFFed5f34),
          background: Colors.amber[50],
        ),
      ),
      initialRoute: Splash.routeName,
      routes: {
        Splash.routeName: (context) => const Splash(),
        PgHome.routeName: (context) => const PgHome(),
        PgDetail.routeName: (context) => PgDetail(
            vmRestaurant:
                ModalRoute.of(context)?.settings.arguments as VmRestaurants),
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
