import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:restaurant_app/Pages/pg_detail.dart';
import 'package:restaurant_app/Styling/text_theme.dart';
import 'package:restaurant_app/ViewModels/vm_restaurants.dart';

class PgHome extends StatelessWidget {
  const PgHome({super.key});

  static const String routeName = '/pgHome';

  List<VmRestaurants> parseJson(String? json) {
    if (json == null) {
      return [];
    }

    final List parsed = jsonDecode(json)['restaurants'];
    return parsed.map((json) => VmRestaurants.fromJson(json)).toList();
  }

  Widget _buildListItem(BuildContext context, VmRestaurants vmRestaurant) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, PgDetail.routeName,
            arguments: vmRestaurant),
        leading: Hero(
          tag: vmRestaurant.id,
          child: Image.network(
            vmRestaurant.imageUrl,
            fit: BoxFit.cover,
            width: 100,
            errorBuilder: (ctx, error, _) =>
                const Center(child: Icon(Icons.error)),
          ),
        ),
        title: Text(
          vmRestaurant.name,
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
                  vmRestaurant.city,
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
                  '${vmRestaurant.rating}',
                  style: myTextTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<String> listViewBuilder(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json'),
      builder: (context, snapshot) {
        final List<VmRestaurants> restaurant = parseJson(snapshot.data);
        return ListView.builder(
          itemCount: restaurant.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                _buildListItem(context, restaurant[index]),
                Divider(
                  color: Colors.deepPurple[200],
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: innerBoxIsScrolled
                  ? Colors.deepPurple
                  : Colors.deepPurple[50],
              title: innerBoxIsScrolled
                  ? Container()
                  : Hero(
                      tag: 'appName',
                      child: Text(
                        'Dicoding Restaurant App',
                        style: myTextTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
              snap: true,
              pinned: true,
              floating: true,
              elevation: 2,
              forceElevated: innerBoxIsScrolled,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(64),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 10,
                    right: 20,
                    bottom: 20,
                  ),
                  child: Text(
                    'Restaurant recommendation for you',
                    style: myTextTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: innerBoxIsScrolled ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: listViewBuilder(context),
      ),
    );
  }
}
