import 'package:flutter/material.dart';

class WgBackButton extends StatelessWidget {
  const WgBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 32),
      color: Color(0xFFed5f34),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        ),
      ),
      // shape: const CircleBorder(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
