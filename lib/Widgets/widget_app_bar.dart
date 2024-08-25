import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_app/Common/text_theme.dart';

class WidgetAppBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? searchBox;

  const WidgetAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    this.searchBox,
  });

  @override
  Widget build(BuildContext context) {
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
                title,
                style: myTextTheme.headlineMedium!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: myTextTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      snap: true,
      pinned: true,
      floating: true,
      bottom: PreferredSize(
        preferredSize: searchBox == null
            ? const Size.fromHeight(0)
            : const Size.fromHeight(96),
        child: searchBox == null ? Container() : searchBox!,
      ),
    );
  }
}
