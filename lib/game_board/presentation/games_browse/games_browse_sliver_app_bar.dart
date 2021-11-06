import 'package:flutter/material.dart';

import '../../../constants/app_constants.dart';
import 'filters/browse_page_filters.dart';

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
              showDialog(context: context, builder: (context){
                return BrowsePageFilters();
              });
            },
            icon: const Icon(Icons.filter_list))
      ],
    );
  }
}
