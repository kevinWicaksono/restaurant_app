import 'package:flutter/material.dart';

class UtilSpacer {
  static SizedBox vertical([double spaceHeight = 8]) {
    return SizedBox(height: spaceHeight);
  }

  static SizedBox horizontal([double spaceWidth = 8]) {
    return SizedBox(width: spaceWidth);
  }
}
