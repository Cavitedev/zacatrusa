import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zacatrusa/game_board/infrastructure/core/scrapping_failures.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/browse_page/game_overview.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_page_query_parameter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/zacatrus_url_composer.dart';
import 'package:zacatrusa/game_board/zacatrus/infrastructure/zacatrus_browse_page_scrapper.dart';

void main() {
  ProviderContainer container = ProviderContainer();

  setUp(() {
    container = ProviderContainer();
  });

  group("Get Games Overview", () {
    test("Default object loads page", () async {
      final ZacatrusBrowsePageScapper scrapper = container.read(zacatrusBrowsePageScrapperProvider);

      final httpCall =
          scrapper.getGamesOverviews(ZacatrusUrlBrowserComposer.init());

      final result = await httpCall.skip(1).first;

      final pageDate = result.getRight()!;
      final listGames = pageDate.games;

      expect(listGames.length, 24);
      expect(pageDate.amount, greaterThanOrEqualTo(7196));

      final GameOverview game1 = listGames.first;

      expect(game1.name, isNot("Error retrieving game"));

      expect(game1.name, isNot(startsWith(" ")));
      expect(game1.name, isNot(startsWith("\n")));

      expect(game1.link, isNotNull);

      expect(game1.image, isNotNull);
      expect(game1.image!.imageLink, isNotNull);
      expect(game1.image!.imageAlt, isNotNull);

      expect(game1.numberOfComments, isNotNull);

      expect(game1.stars, isNotNull);

      expect(game1.price, isNotNull);
    });

    test("Returns no games found on not matching filters", () async {
      final ZacatrusBrowsePageScapper scrapper = container.read(zacatrusBrowsePageScrapperProvider);

      final result =
          scrapper.getGamesOverviews(ZacatrusUrlBrowserComposer.init().copyWith(
        pageNum: const ZacatrusPageIndex(999999),
      ));

      final firstRes = await result.skip(1).first;
      final failure = firstRes.getLeft()!;
      expect(failure, isA<NoGamesFailure>());
    });
  });
}
