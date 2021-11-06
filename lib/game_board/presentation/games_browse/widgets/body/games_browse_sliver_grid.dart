import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../../constants/app_margins.dart';
import '../../../../zacatrus/domain/browse_page/game_overview.dart';

class GamesBrowseSliverGrid extends StatelessWidget {
  const GamesBrowseSliverGrid({
    required this.games,
    Key? key,
  }) : super(key: key);

  final List<GameOverview> games;

  @override
  Widget build(BuildContext context) {
    final double mainAxisExtent =
        MediaQuery.of(context).textScaleFactor * 85 + 200;

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 256,
        mainAxisExtent: mainAxisExtent,
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
            ExtendedImage.network(
              game.image!.imageLink!,
              height: 150,
              width: 150,
              semanticLabel: game.image?.imageAlt,
            ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GameName(game: game),
              if (game.numberOfComments != null) Comments(game: game),
              if (game.stars != null) Stars(game: game),
              if (game.price != null) Price(game: game),
            ],
          ))
        ],
      ),
    );
  }
}

class GameName extends StatelessWidget {
  const GameName({
    Key? key,
    required this.game,
  }) : super(key: key);

  final GameOverview game;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: innerElementsPadding),
      child: Text(
        game.name,
        style: Theme.of(context).textTheme.headline5,
        maxLines: 2,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class Comments extends StatelessWidget {
  const Comments({
    Key? key,
    required this.game,
  }) : super(key: key);

  final GameOverview game;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: innerElementsPadding),
      child: Text(
        game.numberOfComments!.toString() +
            (game.numberOfComments! > 1 ? " comentarios" : " comentario"),
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }
}

class Stars extends StatelessWidget {
  const Stars({
    Key? key,
    required this.game,
  }) : super(key: key);

  final GameOverview game;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: innerElementsPadding),
      child: RatingBarIndicator(
        itemBuilder: (context, index) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        rating: game.stars!,
        itemSize: 25.0,
      ),
    );
  }
}

class Price extends StatelessWidget {
  const Price({
    Key? key,
    required this.game,
  }) : super(key: key);

  final GameOverview game;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: innerElementsPadding),
      child: Text(
        game.price!.toStringAsFixed(2) + " €",
        style: Theme.of(context)
            .textTheme
            .subtitle2!
            .copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
