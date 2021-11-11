import 'package:zacatrusa/core/optional.dart';

import '../../../infrastructure/core/internet_feedback.dart';
import '../../../zacatrus/domain/details_page/reviews/game_review.dart';

class ReviewsState {
  final List<GameReview> gameReviews;
  final InternetFeedback? internetFeedback;
  final int? actualAmountOfReviews;

//<editor-fold desc="Data Methods">

  const ReviewsState({
    required this.gameReviews,
    this.internetFeedback,
    this.actualAmountOfReviews,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewsState &&
          runtimeType == other.runtimeType &&
          gameReviews == other.gameReviews &&
          internetFeedback == other.internetFeedback);

  @override
  int get hashCode => gameReviews.hashCode ^ internetFeedback.hashCode;

  @override
  String toString() {
    return 'ReviewsState{' +
        ' gameReviews: $gameReviews,' +
        ' internetFeedback: $internetFeedback,' +
        '}';
  }

  ReviewsState copyWith({
    List<GameReview>? gameReviews,
    Optional<InternetFeedback?>? internetFeedback,
    Optional<int?>? actualAmountOfReviews,
  }) {
    return ReviewsState(
      gameReviews: gameReviews ?? this.gameReviews,
      internetFeedback: internetFeedback == null
          ? this.internetFeedback
          : internetFeedback.value,
      actualAmountOfReviews: actualAmountOfReviews == null
          ? this.actualAmountOfReviews
          : actualAmountOfReviews.value,
    );
  }

//</editor-fold>
}
