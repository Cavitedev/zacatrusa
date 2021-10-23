import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/dom.dart' as dom;
import 'package:zacatrusa/core/multiple_result.dart';
import 'package:zacatrusa/game_board/domain/zacatrus/game_overview.dart';
import 'package:zacatrusa/game_board/domain/zacatrus/url/zacatrus_url_composer.dart';
import 'package:zacatrusa/game_board/infrastructure/core/internet_feedback.dart';
import 'package:zacatrusa/game_board/infrastructure/zacatrus/zacatrus_game_browser_parser.dart';

import '../http_loader.dart';

final zacatrusScrapperProvider = Provider((ref) => ZacatrusScapper(ref: ref));

class ZacatrusScapper {
  ZacatrusScapper({
    required this.ref,
  });

  final ProviderRef ref;
  final ZacatrusUrlBrowserComposer urlComposer = ZacatrusUrlBrowserComposer();

  Stream<Either<InternetFeedback, List<GameOverview>>> getGamesOverviews() async* {
    final httpLoader = ref.read(httpLoaderProvider);
    final stream = httpLoader.getPage(url: urlComposer.buildUrl());

    final Stream<Either<InternetFeedback, List<GameOverview>>> mappedStream =
    stream.map((result) {
      if (result.isRight()) {
        final dom.Document doc = result.getRight()!;
        return Right(parseBrowserPage(doc));
      }

      return Left(result.getLeft()!);
    });

    yield* mappedStream;
  }
}
