import 'package:flutter/material.dart';
import 'package:zacatrusa/constants/app_margins.dart';

class GameBrowseSliverGrid extends StatelessWidget {
  const GameBrowseSliverGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 256,
        mainAxisSpacing: listSpacing,
        crossAxisSpacing: listSpacing,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return const Placeholder();
        },
        childCount: 36,
      ),
    );
  }
}
