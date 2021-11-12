import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/game_board/presentation/game_details/states/success/image_carousel_display.dart';

import '../../../../../constants/app_margins_and_sizes.dart';
import '../../../../zacatrus/domain/details_page/zacatrus_details_page_data.dart';
import 'game_details_bottom_navigation_bar.dart';
import 'pages/characterictics/characterictics_page.dart';
import 'pages/game_details_null_data.dart';
import 'pages/purchase/purchase_page.dart';
import 'pages/reviews/reviews_page.dart';
import 'pages/summary/summay_page.dart';

class GameDetailsSuccessBody extends ConsumerWidget {
  const GameDetailsSuccessBody({
    required this.data,
    Key? key,
  }) : super(key: key);

  final ZacatrusDetailsPageData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Key carouselKey = ValueKey(data.imagesCarousel.hashCode);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(data.gameOverview.name),
        ),
        if (data.imagesCarousel != null)
          SliverPadding(
            padding: const EdgeInsets.all(generalPadding),
            sliver: SliverToBoxAdapter(
                child: ImagesCarouselDisplay(
              carousel: data.imagesCarousel!,
              key: carouselKey,
            )),
          ),
        SliverPadding(
          padding: const EdgeInsets.all(generalPadding),
          sliver: _getBody(ref.watch(detailsBottomNavigationProvider)),
        ),
      ],
    );
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return const SummaryPage();
      case 1:
        if (data.gameDataSheet != null) {
          return CharactericticsPage(gameDataSheet: data.gameDataSheet!);
        }
        break;
      case 2:
        return ReviewsPage(
          reviewsUrl: data.reviewsUrl,
        );
      case 3:
        return const PurchasePage();
    }
    return const SliverToBoxAdapter(child: GameDetailsNullData());
  }
}
