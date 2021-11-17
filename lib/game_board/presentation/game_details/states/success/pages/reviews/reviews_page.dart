import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../constants/app_margins_and_sizes.dart';
import '../../../../../../application/details/reviews/reviews_notifier.dart';
import '../../../../../../application/details/reviews/reviews_state.dart';
import '../../../../../../zacatrus/domain/details_page/reviews/game_review.dart';
import '../../../../../../zacatrus/domain/details_page/reviews/reviews_url.dart';
import '../../../../../core/feedback_errors_loading/internet_feedback_widgets.dart';
import '../../../../../core/widgets/game_overview/star_bars_indicator.dart';

class ReviewsPage extends ConsumerWidget {
  const ReviewsPage({this.reviewsUrl, Key? key}) : super(key: key);

  final ReviewsUrl? reviewsUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (reviewsUrl == null) {
      return SliverToBoxAdapter(
        child: Text(
          "No se pudo cargar los comentarios",
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Theme.of(context).errorColor),
        ),
      );
    }

    final ReviewsState state = ref.watch(reviewsNotifierProvider(reviewsUrl!));

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        if (index == 0) {
          return SizedBox(
            width: double.infinity,
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(innerElementsPadding),
                child: Text(
                  "Comentarios (${state.actualAmountOfReviews ?? reviewsUrl!.numberOfReviews})",
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        } else if (index <= state.gameReviews.length) {
          return Review(
            review: state.gameReviews[index - 1],
            index: index,
          );
        }
        if (isThereFeedback(state)) {
          return Padding(
            padding: const EdgeInsets.all(generalPadding),
            child: InternetFeedbackWidget(feedback: state.internetFeedback!),
          );
        }
      },
          childCount:
              state.gameReviews.length + (isThereFeedback(state) ? 2 : 1)),
    );
  }

  bool isThereFeedback(ReviewsState state) => state.internetFeedback != null;
}

class Review extends StatelessWidget {
  const Review({
    required this.review,
    required this.index,
    Key? key,
  })  : semanticValue = "Comentario $index",
        super(key: key);

  final GameReview review;
  final int index;

  final String semanticValue;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.all(listSpacing),
        width: double.infinity,
        child: MergeSemantics(
          child: Semantics(
            value: "Comentario $index",
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.spaceAround,
                  runSpacing: 4,
                  spacing: 16,
                  children: [
                    if (GameReview.isElementValid(review.author))
                      Text(
                        review.author!,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    if (review.stars != null)
                      StarsBarIndicator(stars: review.stars!),
                    if (review.date != null)
                      Text(
                        review.date!,
                        style: Theme.of(context).textTheme.caption,
                      ),
                  ],
                ),
                if (GameReview.isElementValid(review.title))
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: innerElementsPadding),
                    child: Text(
                      review.title!,
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                  ),
                if (review.description != null)
                  Semantics(
                    label: review.description!,
                    child: SelectableText(
                      review.description!,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
