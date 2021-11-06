import 'package:zacatrusa/core/optional.dart';

import '../../../infrastructure/core/internet_feedback.dart';
import '../../domain/game_overview.dart';
import '../../domain/url/zacatrus_url_composer.dart';

class ZacatrusBrowserState {
  const ZacatrusBrowserState({
    required this.urlComposer,
    required this.games,
    this.loadingFeedback,
    this.gamesFound,
  });

  final ZacatrusUrlBrowserComposer urlComposer;
  final List<GameOverview> games;
  final InternetFeedback? loadingFeedback;
  final int? gamesFound;

  factory ZacatrusBrowserState.init() {
    return ZacatrusBrowserState(
        urlComposer: ZacatrusUrlBrowserComposer.init(), games: []);
  }

  ZacatrusBrowserState addGames(List<GameOverview> addedGames) {
    return copyWith(games: [...games, ...addedGames], loadingFeedback: null);
  }

  bool get isLoaded => loadingFeedback == null;

  bool get allGamesFetched => gamesFound == games.length;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZacatrusBrowserState &&
          runtimeType == other.runtimeType &&
          urlComposer == other.urlComposer &&
          games == other.games &&
          loadingFeedback == other.loadingFeedback &&
          gamesFound == other.gamesFound;

  @override
  int get hashCode =>
      urlComposer.hashCode ^
      games.hashCode ^
      loadingFeedback.hashCode ^
      gamesFound.hashCode;

  //<editor-fold desc="Data Methods">




  @override
  String toString() {
    return 'ZacatrusBrowserState{urlComposer: $urlComposer, games: $games, loadingFeedback: $loadingFeedback, gamesFound: $gamesFound}';
  }

  ZacatrusBrowserState copyWith({
    ZacatrusUrlBrowserComposer? urlComposer,
    List<GameOverview>? games,
    InternetFeedback? loadingFeedback,
    Optional<int?>? gamesFound,
  }) {
    return ZacatrusBrowserState(
      urlComposer: urlComposer ?? this.urlComposer,
      games: games ?? this.games,
      loadingFeedback: loadingFeedback,
      gamesFound: gamesFound == null ? this.gamesFound : gamesFound.value
    );
  }

//</editor-fold>
}
