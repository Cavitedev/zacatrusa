import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../constants/app_margins.dart';
import '../../../../zacatrus/domain/details_page/zacatrus_details_page_data.dart';
import 'pages/characterictics/characterictics_page.dart';
import 'pages/purchase/purchase_page.dart';
import 'pages/reviews/reviews_page.dart';
import 'pages/summary/summay_page.dart';

final StateProvider<int> detailsBottomNavigationProvider =
    StateProvider<int>((_) => 0);

class GameDetailsSuccess extends ConsumerWidget {
  const GameDetailsSuccess({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ZacatrusDetailsPageData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int navigationIndex = ref.watch(detailsBottomNavigationProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(data.gameOverview.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(generalPadding),
        child: data.imagesCarousel,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationIndex,
        onTap: (newIndex) {
          ref.read(detailsBottomNavigationProvider.notifier).state = newIndex;
        },
        unselectedItemColor: Colors.black26,
        selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.summarize_outlined), label: "Resumen"),
          BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined), label: "Características"),
          BottomNavigationBarItem(
              icon: Icon(Icons.reviews_outlined), label: "Comentarios"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: "Compra"),
        ],
      ),
    );
  }

  Widget? _getBody(int index) {
    switch (index) {
      case 0:
        return const SummaryPage();
      case 1:
        return const CharactericticsPage();
      case 2:
        return ReviewsPage(
          reviewsUrl: data.reviewsUrl,
        );
      case 3:
        return const PurchasePage();
    }
  }
}
