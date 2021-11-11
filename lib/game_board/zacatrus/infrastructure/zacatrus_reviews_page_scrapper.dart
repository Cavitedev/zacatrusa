import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/dom.dart' as dom;

import '../../../core/multiple_result.dart';
import '../../../core/string_helper.dart';
import '../../infrastructure/core/internet_feedback.dart';
import '../../infrastructure/core/scrapping_failures.dart';
import '../../infrastructure/http_loader.dart';
import '../domain/details_page/reviews/game_review.dart';

final zacatrusReviewPageScrapperProvider =
    Provider((ref) => ZacatrusReviewPageScrapper(ref));

class ZacatrusReviewPageScrapper {
  ZacatrusReviewPageScrapper(this.ref);

  final ProviderRef ref;

  Stream<Either<InternetFeedback, List<GameReview>>> getReviews(
      String url) async* {
    final httpLoader = ref.read(httpLoaderProvider);
    final stream = httpLoader.getPage(url: url);

    final Stream<Either<InternetFeedback, List<GameReview>>> mappedStream =
        stream.map((result) {
      if (result.isRight()) {
        final dom.Document doc = result.getRight()!;
        final data = _parseReviewsPage(doc, url);
        return data;
      }

      return Left(result.getLeft()!);
    });

    yield* mappedStream;
  }

  Either<InternetFeedback, List<GameReview>> _parseReviewsPage(
      dom.Document doc, String url) {
    try {
      List<GameReview> reviews = [];

      List<dom.Element> liReviews =
          doc.getElementsByClassName("items review-items")[0].children;
      for (final lireview in liReviews) {
        GameReview? review = _parseReview(lireview);
        if (review != null && review.isValid()) {
          reviews.add(review);
        }
      }

      return Right(reviews);
    } catch (_) {
      return Left(ParsingFailure(url: url));
    }
  }

  GameReview? _parseReview(dom.Element liReview) {
    try {
      GameReview gameReview = GameReview();
      gameReview.title = _parseTitleFromReview(liReview);
      gameReview.stars = _parseStarsFromReview(liReview);
      gameReview.description = _parseDescriptionsFromReview(liReview);
      gameReview.author = _parseAuthorFromReview(liReview);
      gameReview.date = _parseDateFromReview(liReview);

      return gameReview;
    } catch (_) {
      //No data
    }
  }

  String? _parseTitleFromReview(dom.Element liReview) {
    try {
      final dom.Element titleElement =
          liReview.getElementsByClassName("review-title")[0];
      String title = titleElement.text.trim();
      return title;
    } catch (_) {
      //No data
    }
  }

  double? _parseStarsFromReview(dom.Element liReview) {
    try {
      final dom.Element starsElement =
          liReview.getElementsByClassName("rating-result")[0];
      String starsPercentage = starsElement.attributes["title"]!;
      double stars = starsPercentage.toNum() / 20;
      return stars;
    } catch (_) {
      //No data
    }
  }

  String? _parseDescriptionsFromReview(dom.Element liReview) {
    try {
      final dom.Element descriptionsElement =
          liReview.getElementsByClassName("review-content")[0];
      String descriptions = descriptionsElement.text;
      return descriptions.trim();
    } catch (_) {
      //No data
    }
  }

  String? _parseAuthorFromReview(dom.Element liReview) {
    try {
      final dom.Element authorElement = liReview
          .getElementsByClassName("review-author")[0]
          .getElementsByClassName("review-details-value")[0];
      String author = authorElement.text.trim();
      return author;
    } catch (_) {
      //No data
    }
  }

  String? _parseDateFromReview(dom.Element liReview) {
    try {
      final dom.Element dateElement = liReview
          .getElementsByClassName("review-date")[0]
          .getElementsByClassName("review-details-value")[0];
      String date = dateElement.text.trim();
      return date;
    } catch (_) {
      //No data
    }
  }
}
