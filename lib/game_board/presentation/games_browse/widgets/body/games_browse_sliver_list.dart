import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/constants/app_margins.dart';
import 'package:zacatrusa/core/optional.dart';
import 'package:zacatrusa/game_board/presentation/core/routing/games_router_delegate.dart';
import 'package:zacatrusa/game_board/presentation/core/widgets/star_bars_indicator.dart';

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

class ListGameItem extends ConsumerWidget {
  const ListGameItem({
    Key? key,
    required this.game,
  }) : super(key: key);

  final GameOverview game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (game.image != null && game.image!.imageLink != null)
                ExtendedImage.network(
                  game.image!.imageLink!,
                  fit: BoxFit.fill,
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
                    if (game.numberOfComments != null &&
                        game.numberOfComments! > 1)
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
                    if (game.numberOfComments != null &&
                        game.numberOfComments == 1)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            5, 0, 0, innerElementsPadding),
                        child: Text(
                            game.numberOfComments!.toString() + " comentario"),
                      ),
                    if (game.stars != null)
                      StarsBarIndicator(stars: game.stars!),
                    if (game.price != null)
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
        ),
        Positioned.fill(
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    final routerDelegate =
                        ref.read(gamesRouterDelegateProvider);

                    routerDelegate.currentConf = routerDelegate.currentConf
                        .copyWith(detailsGameUrl: Optional.value(game.link));
                  },
                ))),
      ],
    );
  }
}
