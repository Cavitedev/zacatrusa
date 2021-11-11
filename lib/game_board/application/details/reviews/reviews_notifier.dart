import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/optional.dart';
import '../../../zacatrus/domain/details_page/reviews/reviews_url.dart';
import '../../../zacatrus/domain/url/filters/zacatrus_page_query_parameter.dart';
import '../../../zacatrus/infrastructure/zacatrus_reviews_page_scrapper.dart';
import 'reviews_state.dart';

final reviewsNotifierProvider =
    StateNotifierProvider.family<ReviewsNotifier, ReviewsState, ReviewsUrl>(
        (ref, url) =>
            ReviewsNotifier(ref.read(zacatrusReviewPageScrapperProvider), url));

class ReviewsNotifier extends StateNotifier<ReviewsState> {
  ReviewsNotifier(this.scrapper, this.reviewUrl)
      : super(const ReviewsState(gameReviews: [])) {
    loadReviews();
  }

  final ZacatrusReviewPageScrapper scrapper;
  ReviewsUrl reviewUrl;

  StreamSubscription? subscription;
  int reviewsRetrieved = 0;
  int nonValidReviews = 0;

  void loadReviews() {
    if (reviewUrl.numberOfReviews <= state.gameReviews.length) {
      return;
    }

    subscription?.cancel();
    subscription = scrapper.getReviews(reviewUrl.buildUrl()).listen((event) {
      event.when((left) {
        state = state.copyWith(internetFeedback: Optional.value(left));
      }, (right) {
        state = state.copyWith(
            gameReviews: [...state.gameReviews, ...right],
            internetFeedback: const Optional.value(null));
        reviewUrl = reviewUrl.nextPage();
      });
    })
      ..onDone(() {
        subscription = null;
      });
  }

  void nextPageIfNotLoading() {
    if (subscription == null) {
      loadReviews();
    }
  }

  void clear() {
    state = state.copyWith(
        gameReviews: [], internetFeedback: const Optional.value(null));
    reviewUrl = reviewUrl.copyWith(pageIndex: const ZacatrusPageIndex(1));
    loadReviews();
  }
}
