import 'package:flutter/material.dart';
import 'package:restaurant_app/Pages/page_detail.dart';
import 'package:restaurant_app/Pages/page_home.dart';
import 'package:restaurant_app/Common/text_theme.dart';
import 'package:restaurant_app/Data/Models/model_restaurant.dart';
import 'package:restaurant_app/Widgets/widget_splashscreen.dart';

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
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFa32600),
          surface: Color(0xFFed5f34),
        ),
      ),
      initialRoute: Splash.routeName,
      routes: {
        Splash.routeName: (context) => const Splash(),
        PageHome.routeName: (context) => const PageHome(),
        PageDetail.routeName: (context) => PageDetail(
            vmRestaurant:
                ModalRoute.of(context)?.settings.arguments as ModelRestaurants),
      },
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return WidgetSplashScreen(
      appName: 'Dicoding Restaurant App',
      imgSplash: Image.asset('assets/dicoding_logo.png'),
      splashDuration: 3,
      afterSplash: PageHome.routeName,
    );
  }
}
