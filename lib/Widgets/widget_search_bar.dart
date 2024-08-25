import 'package:flutter/material.dart';
import 'package:restaurant_app/Common/text_theme.dart';

class WidgetSearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onFieldSubmitted;
  final Function() onClear;

  const WidgetSearchBar({
    super.key,
    required this.searchController,
    required this.onFieldSubmitted,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.only(
          left: 8,
        ),
        child: TextFormField(
          controller: searchController,
          style: myTextTheme.bodyMedium!.copyWith(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: 'Search Restaurant Name',
            hintStyle: myTextTheme.bodyMedium!.copyWith(
              color: Colors.grey[850],
            ),
            border: InputBorder.none,
            suffixIcon: InkWell(
              onTap: onClear,
              child: Icon(
                Icons.clear,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
          ),
          onFieldSubmitted: onFieldSubmitted,
        ),
      ),
    );
  }
}
