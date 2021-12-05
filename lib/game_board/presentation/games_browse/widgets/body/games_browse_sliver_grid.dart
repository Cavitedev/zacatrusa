import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../constants/app_margins_and_sizes.dart';
import '../../../../../core/optional.dart';
import '../../../../zacatrus/domain/browse_page/game_overview.dart';
import '../../../core/routing/games_router_delegate.dart';
import '../../../core/widgets/game_overview/price.dart';
import '../../../core/widgets/game_overview/reviews_number.dart';
import '../../../core/widgets/game_overview/star_bars_indicator.dart';

class GamesBrowseSliverGrid extends StatelessWidget {
  const GamesBrowseSliverGrid({
    required this.games,
    Key? key,
  }) : super(key: key);

  final List<GameOverview> games;

  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    final double mainAxisExtent =
        MediaQuery.of(context).textScaleFactor * 90 + 200;

    double maxCrossAxis = 256 * textScaleFactor;

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: maxCrossAxis,
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
            child: Semantics(
              onTapHint: "Ir a pantalla de detalles",
              onTap: () {
                _detailsPage(ref);
              },
              button: true,
              child: Column(
                children: [
                  if (game.image != null)
                    ExtendedImage.network(
                      game.image!.imageLink!,
                      height: 150,
                      width: 150,
                    ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: innerElementsPadding),
                          child: GameName(game: game),
                        ),
                        if (game.numberOfReviews != null)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: ReviewsNumber(
                              numberReviews: game.numberOfReviews!,
                            ),
                          ),
                        if (game.stars != null)
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: innerElementsPadding),
                              child: StarsBarIndicator(stars: game.stars!)),
                        if (game.price != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: innerElementsPadding),
                            child: PriceText(price: game.price!),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    _detailsPage(ref);
                  },
                ))),
      ],
    );
  }

  void _detailsPage(WidgetRef ref) {
    final routerDelegate = ref.read(gamesRouterDelegateProvider);

    routerDelegate.currentConf = routerDelegate.currentConf
        .copyWith(detailsGameUrl: Optional.value(game.link));
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
        style: Theme.of(context).textTheme.headline6?.copyWith(height: 1.1),
        maxLines: 2,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
