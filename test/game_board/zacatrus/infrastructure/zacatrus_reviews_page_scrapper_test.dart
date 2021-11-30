import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/details_page/reviews/game_review.dart';
import 'package:zacatrusa/game_board/zacatrus/infrastructure/zacatrus_reviews_page_scrapper.dart';

void main() {
  ProviderContainer container = ProviderContainer();

  setUp(() {
    container = ProviderContainer();
  });

  group("Scrap reviews page", () {
    test("Scrapping page returns all data", () async {
      final ZacatrusReviewPageScrapper scrapper =
          container.read(zacatrusReviewPageScrapperProvider);

      const String url =
          "https://zacatrus.es/review/product/listAjax/id/19636/?limit=50";

      final httpCall = scrapper.getReviews(url);
      final result = await httpCall.skip(1).first;

      expect(result.isRight(), isTrue);

      final List<GameReview> reviews = result.getRight()!;

      expect(reviews.length, greaterThanOrEqualTo(17));
      GameReview firstReview = reviews.first;
      expect(firstReview.title, isNotNull);
      expect(firstReview.stars, isNotNull);
      expect(firstReview.description, isNotNull);
      expect(firstReview.author, isNotNull);
      expect(firstReview.date, isNotNull);
    });
  });
}
