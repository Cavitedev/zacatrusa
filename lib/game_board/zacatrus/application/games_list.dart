import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/core/multiple_result.dart';
import 'package:zacatrusa/game_board/infrastructure/core/internet_feedback.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/game_overview.dart';
import 'package:zacatrusa/game_board/zacatrus/infrastructure/zacatrus_scrapper.dart';

final gamesListNotifierProvider =
    StateNotifierProvider<GamesListNotifier, List<GameOverview>>(
        (ref) => GamesListNotifier());

final zacatrusGameListProvider = Provider.autoDispose<
    AsyncValue<Either<InternetFeedback, List<GameOverview>>>>((ref) {
  final zacatrusGetGamesOverview = ref.watch(zacatrusGetGamesOverviewProvider);
  final gameListNotifier = ref.watch(gamesListNotifierProvider.notifier);

  return zacatrusGetGamesOverview.whenData((value) {
    if (value.isRight()) {
      gameListNotifier.addGames(value.getRight()!);
      return Right(gameListNotifier.state);
    } else {
      return value;
    }
  });
});

class GamesListNotifier extends StateNotifier<List<GameOverview>> {
  GamesListNotifier() : super([]);

  void addGames(List<GameOverview> games) {
    state = [...state, ...games];
  }
}
