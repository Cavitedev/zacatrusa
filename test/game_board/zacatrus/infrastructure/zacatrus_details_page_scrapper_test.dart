import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/details_page/game_overview_details.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/details_page/zacatrus_details_page_data.dart';
import 'package:zacatrusa/game_board/zacatrus/infrastructure/zacatrus_details_page_scrapper.dart';

void main() {
  ProviderContainer container = ProviderContainer();

  setUp(() {
    container = ProviderContainer();
  });

  group("Scrap summary page", () {
    test("Scrap first game Unánimo", () async {
      final ZacatrusDetailsPageScapper scrapper =
          container.read(zacatrusDetailsPageScrapperProvider);

      const link = "https://zacatrus.es/unanimo.html";

      final httpCall = scrapper.getGameDetails(link);

      final result = await httpCall.skip(1).first;

      expect(result.isRight(), isTrue);

      final ZacatrusDetailsPageData data = result.getRight()!;

      final imagesCarousel = data.imagesCarousel!;

      expect(imagesCarousel.items.length, 11);

      final GameOverviewDetails gameOverview = data.gameOverview;
      expect(gameOverview.name, "Unánimo");
      expect(gameOverview.link, link);
      expect(gameOverview.available, "Disponible");
      expect(gameOverview.stars, 4.75);
      expect(gameOverview.price, 9.95);
      expect(gameOverview.numberOfComments, 16);
    });
  });
}
