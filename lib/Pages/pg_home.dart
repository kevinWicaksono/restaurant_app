import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:restaurant_app/Pages/pg_detail.dart';
import 'package:restaurant_app/Styling/text_theme.dart';
import 'package:restaurant_app/ViewModels/vm_restaurants.dart';

class PgHome extends StatefulWidget {
  const PgHome({super.key});

  static const String routeName = '/pgHome';

  @override
  State<PgHome> createState() => _PgHomeState();
}

class _PgHomeState extends State<PgHome> {
  TextEditingController searchController = TextEditingController();

  List<VmRestaurants> parseJson(String? json) {
    if (json == null) {
      return [];
    }

    final List parsed = jsonDecode(json)['restaurants'];
    return parsed.map((json) => VmRestaurants.fromJson(json)).toList();
  }

  Widget _buildListItem(BuildContext context, VmRestaurants vmRestaurant) {
    if (searchController.text.isEmpty) {
      return Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1.5,
              color: Color(0xFFfcd8cc),
            ),
          ),
        ),
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 5,
        ),
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
            style:
                myTextTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
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

    return vmRestaurant.name
            .toLowerCase()
            .contains(searchController.text.toLowerCase())
        ? Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1.5,
                  color: Color(0xFFfcd8cc),
                ),
              ),
            ),
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 5,
            ),
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
                style: myTextTheme.titleMedium!
                    .copyWith(fontWeight: FontWeight.w700),
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
          )
        : Container();
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
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 40,
                    right: 16,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dicoding Restaurant App',
                        style: myTextTheme.headlineMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Restaurant recommendation for you',
                        style: myTextTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              snap: true,
              pinned: true,
              floating: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(96),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(
                    left: 24,
                    top: 16,
                    right: 24,
                    bottom: 16,
                  ),
                  child: TextField(
                    controller: searchController,
                    style: myTextTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search Restaurant Name',
                      hintStyle: myTextTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    onChanged: (String value) {
                      setState(() {});
                    },
                  ),
                  // child: innerBoxIsScrolled || searchController.text.isNotEmpty
                  //     ? TextField(
                  //         controller: searchController,
                  //         style: myTextTheme.bodyLarge!.copyWith(
                  //             fontWeight: FontWeight.w600,
                  //             color: Colors.white,
                  //           ),
                  //         decoration: InputDecoration(
                  //           hintText: 'Search Restaurant Name',
                  //           hintStyle: myTextTheme.bodyLarge!.copyWith(
                  //             fontWeight: FontWeight.w600,
                  //             color: Colors.white,
                  //           ),
                  //           labelStyle: myTextTheme.bodyLarge!.copyWith(
                  //             fontWeight: FontWeight.w600,
                  //             color: Colors.white,
                  //           ),
                  //         ),
                  //         onChanged: (String value) {
                  //           setState(() {});
                  //         },
                  //       )
                  //     : Text(
                  //         'Recommendation for you',
                  //         textAlign: TextAlign.left,
                  //         style: myTextTheme.bodyLarge!.copyWith(
                  //           fontWeight: FontWeight.w600,
                  //           color: Colors.white,
                  //         ),
                  //       ),
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
