import 'dart:math';

import 'package:flutter/material.dart';
import 'package:restaurant_app/Common/text_theme.dart';
import 'package:restaurant_app/Data/Models/model_responses.dart';

class WidgetGridMenu extends StatelessWidget {
  const WidgetGridMenu({
    super.key,
    required this.menus,
    required this.imageList,
    required this.random,
    required this.price,
  });

  final List<ModelMenuName> menus;
  final List imageList;
  final Random random;
  final String price;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: menus.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(80, 158, 158, 158),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(1, 1)),
                BoxShadow(
                    color: Color.fromARGB(80, 255, 255, 255),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(-1, -1)),
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              color: Colors.amber[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    imageList[random.nextInt(imageList.length - 1)],
                    fit: BoxFit.cover,
                    height: 120,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(menus[index].name,
                            style: myTextTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                            )),
                        Text(
                          'IDR $price',
                          style: myTextTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
