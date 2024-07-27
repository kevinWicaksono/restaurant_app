import 'package:flutter/material.dart';
import 'package:restaurant_app/ViewModels/vm_restaurants.dart';

class PgDetail extends StatelessWidget {
  final VmRestaurants vmRestaurant;

  const PgDetail({
    super.key,
    required this.vmRestaurant,
  });

  static const String routeName = '/pgDetail';

  Widget _buildTile(VmRestaurants vmRestaurant) {
    return ListTile(
      title: Text(vmRestaurant.name),
      subtitle: Text(
        vmRestaurant.description,
        overflow: TextOverflow.ellipsis,
        maxLines: 4,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverAppBarDelegate(
              minHeight: 80,
              maxHeight: 160,
              child: Image.network(
                vmRestaurant.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //     (BuildContext context, int index) {
          //       return Padding(
          //         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          //         child: Container(
          //           color: index % 2 == 0 ? Colors.green : Colors.greenAccent,
          //           height: 80,
          //           alignment: Alignment.center,
          //           child: Text(
          //             vmRestaurant.menus.foods[index].name,
          //             style: const TextStyle(fontSize: 30),
          //           ),
          //         ),
          //       );
          //     },
          //     childCount: vmRestaurant.menus.foods.length,
          //   ),
          // ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
              maxCrossAxisExtent: 400.0,
              childAspectRatio: 1.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Container(
                    color: index % 2 == 0 ? Colors.green : Colors.greenAccent,
                    height: 80,
                    alignment: Alignment.center,
                    child: Text(
                      vmRestaurant.menus.foods[index].name,
                      // style: const TextStyle(fontSize: 30),
                    ),
                  ),
                );
              },
              childCount: vmRestaurant.menus.foods.length,
            ),
          )
        ],
      ),
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
