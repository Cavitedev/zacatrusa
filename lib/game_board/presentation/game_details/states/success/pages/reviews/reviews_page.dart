import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/constants/app_margins.dart';
import 'package:zacatrusa/game_board/presentation/core/widgets/star_bars_indicator.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/details_page/game_review.dart';

import '../../../../../../application/details/reviews/reviews_notifier.dart';
import '../../../../../../application/details/reviews/reviews_state.dart';
import '../../../../../../zacatrus/domain/details_page/reviews/reviews_url.dart';

class ReviewsPage extends ConsumerWidget {
  const ReviewsPage({this.reviewsUrl, Key? key}) : super(key: key);

  final ReviewsUrl? reviewsUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (reviewsUrl == null) {
      return Text(
        "No se pudo cargar los comentarios",
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(color: Theme.of(context).errorColor),
      );
    }

    final ReviewsState state = ref.watch(reviewsNotifierProvider(reviewsUrl!));

    return SingleChildScrollView(
      child: Column(
        children: [
          Text("Comentarios\n"),
          ...state.gameReviews
              .map((review) => Review(
                    review: review,
                  ))
              .toList()
        ],
      ),
    );
  }
}

class Review extends StatelessWidget {
  const Review({
    required this.review,
    Key? key,
  }) : super(key: key);

  final GameReview review;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: listSpacing),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (review.author != null)
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
            ),
            if (review.title != null)
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: listSpacing),
                child: Text(
                  review.title!,
                  style: Theme.of(context).textTheme.headline4,
                ),
              )),
            if (review.description != null)
              Flexible(
                  child: Text(
                review.description!,
                style: Theme.of(context).textTheme.bodyText1,
              )),
          ],
        ),
      ),
    );
  }
}
