import 'package:flutter_test/flutter_test.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/details_page/reviews/reviews_url.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_page_query_parameter.dart';

void main() {
  group("Build url", () {
    test("Basic object returns right url", () {
      const ReviewsUrl reviewUrl = ReviewsUrl(
          url: "https://zacatrus.es/reviews/product/listAjax/id/19636/",
          numberOfReviews: 16,
          pageIndex: ZacatrusPageIndex(1));

      expect(reviewUrl.buildUrl(),
          "https://zacatrus.es/reviews/product/listAjax/id/19636/?limit=50");
    });

    test("Next page right url", () {
      final ReviewsUrl reviewUrl = const ReviewsUrl(
              url: "https://zacatrus.es/reviews/product/listAjax/id/19636/",
              numberOfReviews: 16,
              pageIndex: ZacatrusPageIndex(1))
          .nextPage();

      expect(reviewUrl.buildUrl(),
          "https://zacatrus.es/reviews/product/listAjax/id/19636/?p=2&limit=50");
    });
  });
}
