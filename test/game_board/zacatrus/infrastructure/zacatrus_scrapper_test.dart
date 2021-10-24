import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/game_overview.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/zacatrus_url_composer.dart';
import 'package:zacatrusa/game_board/zacatrus/infrastructure/zacatrus_scrapper.dart';

void main() {
  ProviderContainer container = ProviderContainer();

  setUp(() {
    container = ProviderContainer();
  });

  group("Get Games Overview", () {
    test("Default object loads page", () async {
      final ZacatrusScapper scrapper = container.read(zacatrusScrapperProvider);

      final result = scrapper.getGamesOverviews(ZacatrusUrlBrowserComposer());

      final firstRes = await result.skip(1).first;

      final listGames = firstRes.getRight()!;

      expect(listGames.length, 24);

      final GameOverview game1 = listGames.first;

      expect(game1.name, isNot("Error retrieving game"));

      expect(game1.name, isNot(startsWith(" ")));
      expect(game1.name, isNot(startsWith("\n")));

      expect(game1.link, isNotNull);

      expect(game1.imageUrl, isNotNull);

      expect(game1.numberOfComments, isNotNull);

      expect(game1.stars, isNotNull);

      expect(game1.price, isNotNull);
    });
  });
}
