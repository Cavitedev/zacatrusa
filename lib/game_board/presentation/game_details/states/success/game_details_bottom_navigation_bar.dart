import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<int> detailsBottomNavigationProvider =
    StateProvider<int>((_) => 0);

class GameDetailsBottomNavigationBar extends ConsumerWidget {
  const GameDetailsBottomNavigationBar({
    Key? key,
    required this.navigationIndex,
  }) : super(key: key);

  final int navigationIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
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
    );
  }
}
