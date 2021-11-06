import '../../../core/optional.dart';
import '../../infrastructure/core/internet_feedback.dart';
import '../../zacatrus/domain/browse_page/game_overview.dart';
import '../../zacatrus/domain/url/zacatrus_url_composer.dart';

class BrowserState {
  const BrowserState({
    required this.urlComposer,
    required this.games,
    this.loadingFeedback,
    this.gamesFound,
  });

  final ZacatrusUrlBrowserComposer urlComposer;
  final List<GameOverview> games;
  final InternetFeedback? loadingFeedback;
  final int? gamesFound;

  factory BrowserState.init() {
    return BrowserState(
        urlComposer: ZacatrusUrlBrowserComposer.init(), games: []);
  }

  BrowserState addGames(List<GameOverview> addedGames) {
    return copyWith(games: [...games, ...addedGames], loadingFeedback: null);
  }

  bool get isLoaded => loadingFeedback == null;

  bool get allGamesFetched => gamesFound == games.length;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrowserState &&
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

  BrowserState copyWith({
    ZacatrusUrlBrowserComposer? urlComposer,
    List<GameOverview>? games,
    InternetFeedback? loadingFeedback,
    Optional<int?>? gamesFound,
  }) {
    return BrowserState(
      urlComposer: urlComposer ?? this.urlComposer,
      games: games ?? this.games,
      loadingFeedback: loadingFeedback,
      gamesFound: gamesFound == null ? this.gamesFound : gamesFound.value
    );
  }

//</editor-fold>
}
