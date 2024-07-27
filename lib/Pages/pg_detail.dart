import 'dart:math';
import 'package:flutter/material.dart';
import 'package:restaurant_app/Styling/text_theme.dart';
import 'package:restaurant_app/ViewModels/vm_restaurants.dart';
import 'package:restaurant_app/Widgets/wg_back_button.dart';
import 'package:restaurant_app/Widgets/wg_grid_menu.dart';

class PgDetail extends StatelessWidget {
  final VmRestaurants vmRestaurant;

  const PgDetail({
    super.key,
    required this.vmRestaurant,
  });

  static const String routeName = '/pgDetail';

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    List foodImgUrl = [
      'assets/foodImage/orek.jpg',
      'assets/foodImage/steak.jpg',
      'assets/foodImage/sandwich.jpg',
      'assets/foodImage/salad.jpg',
      'assets/foodImage/ramen.jpg',
      'assets/foodImage/pasta.jpg',
    ];
    List drinkImage = [
      'assets/drinkImage/mojito.jpg',
      'assets/drinkImage/matcha.jpg',
      'assets/drinkImage/milkshake.jpg',
      'assets/drinkImage/tea.jpg',
      'assets/drinkImage/coffee.jpg',
      'assets/drinkImage/cocktail.jpg',
      'assets/drinkImage/juice.jpg',
    ];

    return Stack(
      children: [
        Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverAppBarDelegate(
                    minHeight: 80,
                    maxHeight: 160,
                    child: Hero(
                      tag: vmRestaurant.id,
                      child: Image.network(
                        vmRestaurant.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              ];
            },
            body: Container(
              color: Colors.white,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vmRestaurant.name,
                          style: myTextTheme.headlineMedium,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: Colors.red[800],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              vmRestaurant.city,
                              style: myTextTheme.titleMedium,
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
                              '${vmRestaurant.rating}',
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
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          vmRestaurant.description,
                          textAlign: TextAlign.justify,
                          style: myTextTheme.bodyMedium,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Foods',
                          style: myTextTheme.headlineMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        WgGridMenu(
                          vmRestaurant: vmRestaurant,
                          imageList: foodImgUrl,
                          random: random,
                          price: '45.000',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Drinks',
                          style: myTextTheme.headlineMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        WgGridMenu(
                          vmRestaurant: vmRestaurant,
                          imageList: drinkImage,
                          random: random,
                          price: '20.000',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const WgBackButton(),
      ],
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
