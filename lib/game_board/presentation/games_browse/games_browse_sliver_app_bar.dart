import 'package:flutter/material.dart';

import '../../../constants/app_constants.dart';

class GamesBrowseSliverAppBar extends StatelessWidget {
  const GamesBrowseSliverAppBar({
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
