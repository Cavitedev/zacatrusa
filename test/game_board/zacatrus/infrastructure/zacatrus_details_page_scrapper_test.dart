import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/details_page/game_data_sheet.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/details_page/game_overview_details.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/details_page/reviews/reviews_url.dart';
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
      bool validAvailable = gameOverview.available == "Disponible" ||
          gameOverview.available == "No está disponible";
      expect(validAvailable, isTrue);
      expect(gameOverview.price, 11.95);
      expect(gameOverview.numberOfReviews, greaterThanOrEqualTo(17));

      expect(data.gameDescription, isNotNull);

      expect(data.overviewDescription, isNotNull);

      expect(data.gameDataSheet, isNotNull);
      GameDataSheet sheet = data.gameDataSheet!;
      expect(sheet.authors, isNotNull);
      expect(sheet.bgg, isNotNull);
      expect(sheet.mechanic, isNotNull);
      expect(sheet.theme, isNotNull);
      expect(sheet.siBuscas, isNotNull);
      expect(sheet.ageRanges, isNotNull);
      expect(sheet.numPlayers, isNotNull);
      expect(sheet.gameplayDuration, isNotNull);
      expect(sheet.measurements, isNotNull);
      expect(sheet.complexity, isNotNull);
      expect(sheet.language, isNotNull);
      expect(sheet.languageDependency, isNotNull);

      expect(data.reviewsUrl, isNotNull);
      ReviewsUrl reviewUrl = data.reviewsUrl!;
      expect(reviewUrl.numberOfReviews, greaterThanOrEqualTo(16));
      expect(reviewUrl.url,
          "https://zacatrus.es/review/product/listAjax/id/19636/");
    });
  });
}
