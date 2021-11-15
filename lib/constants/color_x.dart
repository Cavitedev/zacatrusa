import 'package:flutter/material.dart';

extension ColorsX on Color {
  Color textColorForThisBackground() {
    return computeLuminance() > 0.33 ? Colors.black : Colors.white;
  }
}
