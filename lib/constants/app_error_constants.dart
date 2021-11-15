import 'package:flutter/material.dart';

class AppErrorConstants {
  static TextStyle errorTextStyle(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline6!
        .copyWith(color: Theme.of(context).errorColor);
  }
}
