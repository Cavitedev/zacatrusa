import 'package:flutter/material.dart';

class GameBrowseSliverList extends StatelessWidget {
  const GameBrowseSliverList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return const Placeholder();
      }, childCount: 36),
    );
  }
}
