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
  int maxReviewsThatCouldLoad = 0;

  void loadReviews() {
    if (_allReviewsHaveBeenLoaded()) {
      return;
    }

    subscription?.cancel();
    subscription = scrapper.getReviews(reviewUrl.buildUrl()).listen((event) {
      event.when((left) {
        state = state.copyWith(internetFeedback: Optional.value(left));
      }, (right) {
        maxReviewsThatCouldLoad += 50;
        int? actualAmountOfReviews;
        if (maxReviewsThatCouldLoad >= reviewUrl.numberOfReviews) {
          actualAmountOfReviews = [...state.gameReviews, ...right].length;
        }
        state = state.copyWith(
            gameReviews: [...state.gameReviews, ...right],
            internetFeedback: const Optional.value(null),
            actualAmountOfReviews: Optional.value(actualAmountOfReviews));
        reviewUrl = reviewUrl.nextPage();
      });
    })
      ..onDone(() {
        subscription = null;
      });
  }

  bool _allReviewsHaveBeenLoaded() =>
      reviewUrl.numberOfReviews <= maxReviewsThatCouldLoad;

  void nextPageIfNotLoading() {
    if (subscription == null) {
      loadReviews();
    }
  }

  void clear() {
    state = state.copyWith(
        gameReviews: [],
        internetFeedback: const Optional.value(null),
        actualAmountOfReviews: const Optional.value(null));
    reviewUrl = reviewUrl.copyWith(pageIndex: const ZacatrusPageIndex(1));
    maxReviewsThatCouldLoad = 0;
    loadReviews();
  }
}
