import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:restaurant_app/Pages/page_detail.dart';
import 'package:restaurant_app/Common/text_theme.dart';
import 'package:restaurant_app/Data/Models/model_restaurant.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  static const String routeName = '/pgHome';

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  TextEditingController searchController = TextEditingController();
  List<ModelRestaurants> listRestaurants = [];
  Random random = Random();

  List<ModelRestaurants> parseJson(String? json) {
    if (json == null) {
      return [];
    }

    final List parsed = jsonDecode(json)['restaurants'];
    return parsed.map((json) => ModelRestaurants.fromJson(json)).toList();
  }

  // app bar widget
  Widget _appBar() {
    return SliverAppBar(
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
        child: _searchBox(),
      ),
    );
  }

  // search box widget
  Widget _searchBox() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
            ),
            BoxShadow(
              color: Colors.white,
              spreadRadius: -2,
              blurRadius: 0.8,
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: TextField(
          controller: searchController,
          style: myTextTheme.bodyMedium!.copyWith(
            color: Colors.black,
          ),
          decoration: InputDecoration.collapsed(
            hintText: 'Search Restaurant Name',
            hintStyle: myTextTheme.bodyMedium!.copyWith(
              color: Colors.grey[850],
            ),
            border: InputBorder.none,
          ),
          onChanged: (String value) {
            setState(() {});
          },
        ),
      ),
    );
  }

  // item list builder
  FutureBuilder<String> listViewBuilder(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json'),
      builder: (context, snapshot) {
        final List<ModelRestaurants> restaurant = parseJson(snapshot.data);
        if (searchController.text.isNotEmpty) {
          listRestaurants.clear();
          for (var item in restaurant) {
            if (item.name
                .toLowerCase()
                .contains(searchController.text.toLowerCase())) {
              listRestaurants.add(item);
            }
          }
        } else {
          listRestaurants = restaurant;
        }
        return ListView.builder(
          itemCount: listRestaurants.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                _buildListItem(context, listRestaurants[index]),
              ],
            );
          },
        );
      },
    );
  }

  // item list design
  Widget _buildListItem(BuildContext context, ModelRestaurants vmRestaurant) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.5,
            color: Color(0xFFf8c4b2),
          ),
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, PageDetail.routeName,
            arguments: vmRestaurant),
        leading: Hero(
          tag: vmRestaurant.id,
          child: Image.network(
            vmRestaurant.imageUrl,
            fit: BoxFit.cover,
            width: 120,
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              _appBar(),
            ];
          },
          body: listViewBuilder(context),
        ),
      ),
    );
  }
}
