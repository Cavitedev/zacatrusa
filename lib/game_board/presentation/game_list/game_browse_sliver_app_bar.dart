import 'package:flutter/material.dart';
import 'package:zacatrusa/constants/app_constants.dart';

class GameBrowseSliverAppBar extends StatelessWidget {
  const GameBrowseSliverAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text(appName),
      floating: true,
      actions: [
        IconButton(
            onPressed: () {
              //TODO add filtering sprint 2
            },
            icon: const Icon(Icons.filter_list))
      ],
    );
  }
}
