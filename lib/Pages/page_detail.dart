import 'dart:math';

import 'package:flutter/material.dart';
import 'package:restaurant_app/Common/text_theme.dart';
import 'package:restaurant_app/Data/Api/api_service.dart';
import 'package:restaurant_app/Data/Models/model_responses.dart';
import 'package:restaurant_app/Utilities/util_spacer.dart';
import 'package:restaurant_app/Widgets/widget_back_button.dart';
import 'package:restaurant_app/Widgets/widget_grid_menu.dart';
import 'package:restaurant_app/Widgets/widget_loading.dart';

class PageDetail extends StatefulWidget {
  final String restaurantId;

  const PageDetail({
    super.key,
    required this.restaurantId,
  });

  static const String routeName = '/pgDetail';

  @override
  State<PageDetail> createState() => _PageDetailState();
}

class _PageDetailState extends State<PageDetail> {
  // START -- PROPERTIES
  final ApiService apiService = ApiService();
  late ModelResponseDetail response;
  late ModelDetailRestaurant restaurantDetail;
  bool isLoading = false;

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
  // END -- PROPERTIES

  // START -- STATES
  @override
  void initState() {
    super.initState();

    getDetailRestaurant(widget.restaurantId);
  }

  @override
  void dispose() {
    super.dispose();
  }
  // END -- STATES

  // START -- FUNCTION
  // get restaurant list from restaurant api
  Future<ModelResponseDetail> getDetailRestaurant(String restaurantId) async {
    setState(() {
      isLoading = true;
    });
    response = await apiService.getDetailRestaurant(restaurantId);

    try {
      if (response.error) {
        throw Exception("failed to load detail restaurant");
      }

      setState(() async {
        restaurantDetail = response.restaurant;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }

    return response;
  }
  // END -- FUNCTION

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: isLoading
              ? const WidgetLoading(
                  loadingText: 'loading data',
                )
              : NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: SliverAppBarDelegate(
                          minHeight: 80,
                          maxHeight: 160,
                          child: Hero(
                            tag: restaurantDetail.id,
                            child: Image.network(
                              'https://restaurant-api.dicoding.dev/images/medium/${restaurantDetail.pictureId}',
                              fit: BoxFit.cover,
                              width: 120,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return SizedBox(
                                  height: 20,
                                  width: 120,
                                  child: Center(
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (ctx, error, _) =>
                                  const Center(child: Icon(Icons.error)),
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
                                restaurantDetail.name,
                                style: myTextTheme.headlineMedium!.copyWith(
                                    color: Theme.of(context).primaryColor),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_rounded,
                                    color: Colors.red[800],
                                  ),
                                  UtilSpacer.horizontal(),
                                  Text(
                                    restaurantDetail.city,
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
                                  UtilSpacer.horizontal(),
                                  Text(
                                    '${restaurantDetail.rating}',
                                    style: myTextTheme.bodyMedium!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  UtilSpacer.horizontal(),
                                  Text(
                                    '(${random.nextInt(5000)} reviews)',
                                    style: myTextTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              UtilSpacer.vertical(24),
                              Text(
                                restaurantDetail.description,
                                textAlign: TextAlign.justify,
                                style: myTextTheme.bodyMedium,
                              ),
                              UtilSpacer.vertical(24),
                              Text(
                                'Foods',
                                style: myTextTheme.headlineMedium!.copyWith(
                                    color: Theme.of(context).primaryColor),
                              ),
                              UtilSpacer.vertical(),
                              WidgetGridMenu(
                                menus: restaurantDetail.menus.foods,
                                imageList: foodImgUrl,
                                random: random,
                                price: '45.000',
                              ),
                              UtilSpacer.vertical(24),
                              Text(
                                'Drinks',
                                style: myTextTheme.headlineMedium!.copyWith(
                                    color: Theme.of(context).primaryColor),
                              ),
                              UtilSpacer.vertical(),
                              WidgetGridMenu(
                                menus: restaurantDetail.menus.drinks,
                                imageList: drinkImage,
                                random: random,
                                price: '20.000',
                              ),
                              UtilSpacer.vertical(24),
                              Text(
                                'Reviews',
                                style: myTextTheme.headlineMedium!.copyWith(
                                    color: Theme.of(context).primaryColor),
                              ),
                              UtilSpacer.vertical(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      restaurantDetail.customerReviews.length,
                                  itemBuilder: (context, index) => Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        restaurantDetail
                                            .customerReviews[index].name,
                                        style: myTextTheme.titleMedium,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text(
                                          restaurantDetail
                                              .customerReviews[index].review,
                                          style: myTextTheme.bodyMedium,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text(
                                          restaurantDetail
                                              .customerReviews[index].date,
                                          style: myTextTheme.bodyMedium,
                                        ),
                                      ),
                                      const Divider(
                                        thickness: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
        const WidgetBackButton(),
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
