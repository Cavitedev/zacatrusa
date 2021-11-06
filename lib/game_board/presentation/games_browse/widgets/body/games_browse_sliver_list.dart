import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:zacatrusa/constants/app_margins.dart';

import '../../../../zacatrus/domain/browse_page/game_overview.dart';

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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (game.image != null && game.image!.imageLink != null)
            ExtendedImage.network(
              game.image!.imageLink!,
              width: min(200, MediaQuery.of(context).size.width / 2.2),
              semanticLabel: game.image?.imageAlt,
            ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
                  child: Text(
                    game.name,
                    style: Theme.of(context).textTheme.headline5,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (game.numberOfComments != null && game.numberOfComments! > 1)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                        5, 0, 0, innerElementsPadding),
                    child: Text(
                      game.numberOfComments!.toString() +
                          (game.numberOfComments! > 1
                              ? " comentarios"
                              : " comentario"),
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                if (game.numberOfComments != null && game.numberOfComments == 1)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                        5, 0, 0, innerElementsPadding),
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
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        5, innerElementsPadding, 0, innerElementsPadding),
                    child: Text(
                      game.price!.toStringAsFixed(2) + " €",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
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
