import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../../constants/app_margins.dart';
import '../../../../zacatrus/domain/game_overview.dart';

class GamesBrowseSliverGrid extends StatelessWidget {
  const GamesBrowseSliverGrid({
    required this.games,
    Key? key,
  }) : super(key: key);

  final List<GameOverview> games;

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
          final GameOverview game = games[index];
          return ListGameItem(game: game);
        },
        childCount: games.length,
      ),
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
      child: Column(
        children: [
          if (game.image != null)
            Image.network(
              game.image!.imageLink!,
              height: 100,
              width: 100,
            ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                game.name,
                style: Theme.of(context).textTheme.headline5,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (game.numberOfComments != null)
                Text(game.numberOfComments!.toString() +
                    (game.numberOfComments! > 1
                        ? " comentarios"
                        : " comentario")),
              if (game.stars != null)
                RatingBarIndicator(
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  rating: game.stars!,
                  itemSize: 25.0,
                ),
              if (game.price != null)
                Text(
                  game.price!.toString() + " €",
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
            ],
          ))
        ],
      ),
    );
  }
}
