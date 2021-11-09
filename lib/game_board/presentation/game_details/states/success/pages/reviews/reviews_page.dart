import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/constants/app_margins.dart';
import 'package:zacatrusa/game_board/presentation/core/feedback_errors_loading/internet_feedback_widgets.dart';
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

    return RefreshIndicator(
      semanticsValue: "Recargar comentarios",
      onRefresh: () async {
        ref.read(reviewsNotifierProvider(reviewsUrl!).notifier).clear();
      },
      child: NotificationListener<ScrollUpdateNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          return _onScroll(scrollInfo, ref, reviewsUrl!);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Comentarios (${reviewsUrl!.numberOfReviews}) \n"),
              ...state.gameReviews
                  .map((review) => Review(
                        review: review,
                      ))
                  .toList(),
              if (state.internetFeedback != null)
                InternetFeedbackWidget(feedback: state.internetFeedback!)
            ],
          ),
        ),
      ),
    );
  }

  bool _onScroll(
      ScrollNotification scrollInfo, WidgetRef ref, ReviewsUrl reviewsUrl) {
    if (scrollInfo.metrics.pixels > scrollInfo.metrics.maxScrollExtent - 300) {
      final zacatrusBrowserNotifier =
          ref.read(reviewsNotifierProvider(reviewsUrl).notifier);

      zacatrusBrowserNotifier.nextPageIfNotLoading();
      return true;
    }
    return false;
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
    return Card(
      child: Container(
        margin: const EdgeInsets.all(listSpacing),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
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
            if (review.title != null)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: innerElementsPadding),
                child: Text(
                  review.title!,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            if (review.description != null)
              Text(
                review.description!,
                style: Theme.of(context).textTheme.bodyText1,
              ),
          ],
        ),
      ),
    );
  }
}
