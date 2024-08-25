import 'dart:math';

import 'package:flutter/material.dart';
import 'package:restaurant_app/Common/text_theme.dart';
import 'package:restaurant_app/Data/Api/api_service.dart';
import 'package:restaurant_app/Data/Models/model_responses.dart';
import 'package:restaurant_app/Pages/page_detail.dart';
import 'package:restaurant_app/Utilities/util_spacer.dart';
import 'package:restaurant_app/Widgets/widget_app_bar.dart';
import 'package:restaurant_app/Widgets/widget_loading.dart';
import 'package:restaurant_app/Widgets/widget_search_bar.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  static const String routeName = '/pgHome';

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  // START -- PROPERTIES
  final ApiService apiService = ApiService();
  late ModelResponseList responses;
  List<ModelRestaurant> restaurantList = [];
  bool isLoading = false;
  Random random = Random();

  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";
  // END -- PROPERTIES

  // START -- STATES
  @override
  void initState() {
    super.initState();

    getRestaurant();
  }

  @override
  void dispose() {
    super.dispose();

    _searchController.dispose();
  }
  // END -- STATES

  // START -- FUNCTION
  // get restaurant list from restaurant api
  Future<List<ModelRestaurant>> getRestaurant() async {
    setState(() {
      restaurantList.clear();
      isLoading = true;
    });
    responses = await apiService.getRestaurantList();

    try {
      if (responses.error) {
        throw Exception("failed to load restaurant list");
      }
      for (var item in responses.restaurants) {
        setState(() {
          restaurantList.add(item);
        });
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }

    return restaurantList;
  }

  // get restaurant with query
  Future<List<ModelRestaurant>> getRestaurantWithQuery(
      String searchQuery) async {
    setState(() {
      restaurantList.clear();
      isLoading = true;
    });
    responses = await apiService.searchRestaurant(searchQuery);

    try {
      if (responses.error) {
        throw Exception("failed to load restaurant list");
      }
      for (var item in responses.restaurants) {
        setState(() {
          restaurantList.add(item);
        });
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }

    return restaurantList;
  }

  // navigate to restaurant detail
  _navigateToPageDetail(String restaurantId) {
    Navigator.pushNamed(context, PageDetail.routeName, arguments: restaurantId);
  }
  // END -- FUNCTION

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              WidgetAppBar(
                title: "Dicoding Restaurant App",
                subtitle: "Restaurant recommendation for you",
                searchBox: WidgetSearchBar(
                  searchController: _searchController,
                  onFieldSubmitted: (String value) {
                    setState(() {
                      _searchController.text.isEmpty
                          ? getRestaurant()
                          : getRestaurantWithQuery(_searchController.text);
                    });
                  },
                  onClear: () {
                    setState(() {
                      _searchController.clear();
                      getRestaurant();
                    });
                  },
                ),
              ),
            ];
          },
          body: isLoading
              ? const WidgetLoading(
                  loadingText: "loading data",
                )
              : restaurantList.isEmpty
                  ? const Center(
                      child: Text("No data found"),
                    )
                  : ListView(
                      padding: const EdgeInsets.all(10),
                      children: restaurantList.map((restaurant) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: ListTile(
                                onTap: () =>
                                    _navigateToPageDetail(restaurant.id),
                                leading: Hero(
                                  tag: restaurant.id,
                                  child: Image.network(
                                    'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
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
                                title: Text(
                                  restaurant.name,
                                  style: myTextTheme.titleMedium,
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
                                          restaurant.city,
                                          style: myTextTheme.bodyMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w700),
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
                                          '${restaurant.rating}',
                                          style: myTextTheme.bodyMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w700),
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
                            ),
                            UtilSpacer.vertical(),
                          ],
                        );
                      }).toList(),
                    ),
        ),
      ),
    );
  }
}
