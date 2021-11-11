import 'package:flutter/material.dart';

class GameDetailsNullData extends StatelessWidget {
  const GameDetailsNullData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "No se pudo cargar está vista. El parseo no ha funcionado completamente bien notífiquelo a los desarrolladores en github",
      style: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(color: Theme.of(context).errorColor),
    );
  }
}
