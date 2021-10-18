import 'package:flutter/material.dart';
import 'package:zacatrusa/game_board/presentation/game_list/widgets/persistent_header.dart';
import 'package:zacatrusa/game_board/presentation/game_list/widgets/sort_change_list_row.dart';

class GameList extends StatelessWidget {
  const GameList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: CustomScrollView(
        slivers: [
          // SliverAppBar(
          //   title: const Text(appName),
          //   floating: true,
          //   actions: [
          //     IconButton(
          //         onPressed: () {
          //           //TODO add filtering sprint 2
          //         },
          //         icon: const Icon(Icons.filter_list))
          //   ],
          // ),
          SliverPersistentHeader(
            delegate: PersistentHeader(
              widget: SortChangeListRow(),
            ),
            floating: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return const Placeholder();
            }, childCount: 36),
          )
        ],
      ),
    );
  }
}
