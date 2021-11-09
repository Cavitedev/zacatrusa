import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          ...state.gameReviews.map((review) => Text(review.title!)).toList()
        ],
      ),
    );
  }
}
