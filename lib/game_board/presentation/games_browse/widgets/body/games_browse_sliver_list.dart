import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../constants/app_margins_and_sizes.dart';
import '../../../../../core/optional.dart';
import '../../../../zacatrus/domain/browse_page/game_overview.dart';
import '../../../core/routing/games_router_delegate.dart';
import '../../../core/widgets/price.dart';
import '../../../core/widgets/reviews_number.dart';
import '../../../core/widgets/star_bars_indicator.dart';

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
                    if (game.numberOfReviews != null &&
                        game.numberOfReviews! > 1)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            5, 0, 0, innerElementsPadding),
                        child: ReviewsNumber(
                          numberReviews: game.numberOfReviews!,
                        ),
                      ),
                    if (game.stars != null)
                      StarsBarIndicator(stars: game.stars!),
                    if (game.price != null)
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                              5, innerElementsPadding, 0, innerElementsPadding),
                          child: PriceText(price: game.price!),
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
