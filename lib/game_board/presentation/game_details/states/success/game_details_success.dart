import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/details/reviews/reviews_notifier.dart';
import '../../../../zacatrus/domain/details_page/reviews/reviews_url.dart';
import '../../../../zacatrus/domain/details_page/zacatrus_details_page_data.dart';
import 'game_details_bottom_navigation_bar.dart';
import 'game_details_success_body.dart';

class GameDetailsSuccess extends ConsumerWidget {
  const GameDetailsSuccess({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ZacatrusDetailsPageData data;
  static const int reviewsNavigationIndex = 2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int navigationIndex = ref.watch(detailsBottomNavigationProvider);

    return Scaffold(
      body: reviewsNavigationIndex == reviewsNavigationIndex
          ? RefreshIndicator(
              semanticsValue: "Recargar comentarios",
              onRefresh: () async {
                ref
                    .read(reviewsNotifierProvider(data.reviewsUrl!).notifier)
                    .clear();
              },
              child: NotificationListener<ScrollUpdateNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  return _onScroll(scrollInfo, ref, data.reviewsUrl!);
                },
                child: GameDetailsSuccessBody(
                  data: data,
                ),
              ),
            )
          : GameDetailsSuccessBody(data: data),
      bottomNavigationBar:
          GameDetailsBottomNavigationBar(navigationIndex: navigationIndex),
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
