import 'dart:math';

import 'package:flutter/material.dart';
import 'package:restaurant_app/Common/text_theme.dart';
import 'package:restaurant_app/Data/Api/api_service.dart';
import 'package:restaurant_app/Data/Models/model_responses.dart';
import 'package:restaurant_app/Widgets/widget_loading.dart';

class WidgetRestaurantListTile extends StatelessWidget {
  final ModelRestaurant modelRestaurant;
  final Function onTap;

  const WidgetRestaurantListTile({
    super.key,
    required this.modelRestaurant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    ApiService apiService = ApiService();

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.5,
            color: Theme.of(context).cardColor,
          ),
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: ListTile(
        onTap: () => onTap,
        leading: Hero(
          tag: modelRestaurant.id,
          child: Image.network(
            "${apiService.getImageUrl()}/${modelRestaurant.pictureId}",
            fit: BoxFit.cover,
            width: 120,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const WidgetLoading();
            },
            errorBuilder: (ctx, error, _) =>
                const Center(child: Icon(Icons.error)),
          ),
        ),
        title: Text(
          modelRestaurant.name,
          style: myTextTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on_rounded,
                  color: Colors.red[800],
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  modelRestaurant.city,
                  style: myTextTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.star_sharp,
                  color: Colors.yellow[700],
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  '${modelRestaurant.rating}',
                  style: myTextTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  '(${random.nextInt(5000)} reviews)',
                  style: myTextTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
