import '../../../infrastructure/core/internet_feedback.dart';
import '../../../zacatrus/domain/details_page/game_review.dart';

class ReviewsState {
  final List<GameReview> gameReviews;
  final InternetFeedback? internetFeedback;

//<editor-fold desc="Data Methods">

  const ReviewsState({
    required this.gameReviews,
    this.internetFeedback,
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
    InternetFeedback? internetFeedback,
  }) {
    return ReviewsState(
      gameReviews: gameReviews ?? this.gameReviews,
      internetFeedback: internetFeedback ?? this.internetFeedback,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'gameReviews': gameReviews,
      'internetFeedback': internetFeedback,
    };
  }

  factory ReviewsState.fromMap(Map<String, dynamic> map) {
    return ReviewsState(
      gameReviews: map['gameReviews'] as List<GameReview>,
      internetFeedback: map['internetFeedback'] as InternetFeedback,
    );
  }

//</editor-fold>
}
