import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/game_overview.dart';

final gamesListNotifierProvider =
    StateNotifierProvider<GamesListNotifier, List<GameOverview>>(
        (ref) => GamesListNotifier());



class GamesListNotifier extends StateNotifier<List<GameOverview>> {
  GamesListNotifier() : super([]);

  void addGames(List<GameOverview> games) {
    state = [...state, ...games];
  }
}
