import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/dom.dart' as dom;
import 'package:zacatrusa/core/multiple_result.dart';
import 'package:zacatrusa/game_board/infrastructure/core/internet_feedback.dart';
import 'package:zacatrusa/game_board/zacatrus/application/games_list.dart';
import 'package:zacatrusa/game_board/zacatrus/application/url/zacatrus_url_browser_notifier.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/game_overview.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/zacatrus_url_composer.dart';
import 'package:zacatrusa/game_board/zacatrus/infrastructure/zacatrus_game_browser_parser.dart';

import '../../infrastructure/http_loader.dart';

final zacatrusScrapperProvider = Provider((ref) => ZacatrusScapper(ref: ref));

final zacatrusGetGamesOverviewProvider = StreamProvider.autoDispose<
    Either<InternetFeedback, List<GameOverview>>>((ref) {
  final scrapper = ref.watch(zacatrusScrapperProvider);
  final urlComposer = ref.watch(zacatrusUrlBrowserNotifierProvider);
  return scrapper.getGamesOverviews(urlComposer);

});

class ZacatrusScapper {
  const ZacatrusScapper({
    required this.ref,
  });

  final ProviderRef ref;

  Stream<Either<InternetFeedback, List<GameOverview>>> getGamesOverviews(
      ZacatrusUrlBrowserComposer urlComposer) async* {
    final httpLoader = ref.read(httpLoaderProvider);
    final stream = httpLoader.getPage(url: urlComposer.buildUrl());

    final Stream<Either<InternetFeedback, List<GameOverview>>> mappedStream =
        stream.map((result) {
      if (result.isRight()) {
        final dom.Document doc = result.getRight()!;
        final games = parseBrowserPage(doc);
        ref.read(gamesListNotifierProvider.notifier).addGames(games);
        return Right(games);
      }

      return Left(result.getLeft()!);
    });

    yield* mappedStream;
  }
}
