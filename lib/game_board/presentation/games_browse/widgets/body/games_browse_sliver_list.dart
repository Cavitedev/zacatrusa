import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../zacatrus/domain/game_overview.dart';

class GamesBrowseSliverList extends StatelessWidget {
  const GamesBrowseSliverList({
    required this.games,
    Key? key,
  }) : super(key: key);

  final List<GameOverview> games;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final GameOverview game = games[index];
        return ListGameItem(game: game);
      }, childCount: games.length),
    );
  }
}

class ListGameItem extends StatelessWidget {
  const ListGameItem({
    Key? key,
    required this.game,
  }) : super(key: key);

  final GameOverview game;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          if (game.image != null) Image.network(game.image!.imageLink!),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 80.0),
                  child: Text(
                    game.name,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                if (game.numberOfComments != null)
                  if (game.numberOfComments! > 1)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 10.0),
                      child: Text(
                          game.numberOfComments!.toString() + " comentarios"),
                    ),
                if (game.numberOfComments == 1)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 10.0),
                    child:
                        Text(game.numberOfComments!.toString() + " comentario"),
                  ),
                if (game.stars != null)
                  RatingBarIndicator(
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    rating: game.stars!,
                    itemSize: 25.0,
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10.0, 0, 0),
                  child: Text(
                    game.price.toString() + " €",
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
