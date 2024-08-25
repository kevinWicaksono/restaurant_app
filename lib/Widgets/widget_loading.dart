import 'package:flutter/material.dart';
import 'package:restaurant_app/Common/text_theme.dart';

class WidgetLoading extends StatelessWidget {
  final String? loadingText;

  const WidgetLoading({
    this.loadingText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: 32,
          height: 32,
          child: CircularProgressIndicator(),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'loading data',
          style: myTextTheme.labelMedium,
        )
      ],
    ));
  }
}
