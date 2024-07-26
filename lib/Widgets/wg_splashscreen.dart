import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_app/Styling/text_theme.dart';

class WgSplashScreen extends StatefulWidget {
  final String appName;
  final dynamic imgSplash;
  final int splashDuration;
  final dynamic afterSplash;
  final dynamic afterSplashArgs;

  const WgSplashScreen({
    super.key,
    required this.appName,
    this.imgSplash,
    required this.splashDuration,
    required this.afterSplash,
    this.afterSplashArgs,
  });

  @override
  State<WgSplashScreen> createState() => _WgSplashScreenState();
}

class _WgSplashScreenState extends State<WgSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: widget.splashDuration), () {
      widget.afterSplash is String
          ? Navigator.pushReplacementNamed(context, widget.afterSplash,
              arguments: widget.afterSplashArgs)
          : Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => widget.afterSplash));
    });
  }

  @override
  Widget build(BuildContext context) {
    // lock the device orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    // get the screen properties
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: screenWidth * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: 'imageSplashScreen',
                          child: widget.imgSplash ?? Container(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Hero(
                          tag: 'appName',
                          child: Text(
                            widget.appName,
                            style: myTextTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Copyright © 2024 - Kevin Wicaksono',
                        style: myTextTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
