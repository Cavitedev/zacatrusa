import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../constants/app_margins_and_sizes.dart';
import '../../../../../core/optional.dart';
import '../../../../zacatrus/domain/browse_page/game_overview.dart';
import '../../../core/routing/games_router_delegate.dart';
import '../../../core/widgets/price.dart';
import '../../../core/widgets/reviews_number.dart';
import '../../../core/widgets/star_bars_indicator.dart';

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
          child: SizedBox(
            width: double.infinity,
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
                    if (game.numberOfReviews != null)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            5, innerElementsPadding, 0, 0),
                        child: ReviewsNumber(
                          numberReviews: game.numberOfReviews!,
                        ),
                      ),
                    if (game.stars != null)
                      Padding(
                          padding:
                              const EdgeInsets.only(top: innerElementsPadding),
                          child: StarsBarIndicator(stars: game.stars!)),
                    if (game.price != null)
                      Padding(
                        padding: const EdgeInsets.only(top: innerElementsPadding),
                        child: PriceText(price: game.price!),
                      ),
                  ],
                ))
              ],
            ),
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
        style: Theme.of(context).textTheme.headline6,
        maxLines: 2,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
