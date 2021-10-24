import '../../../infrastructure/core/internet_feedback.dart';
import '../../domain/game_overview.dart';
import '../../domain/url/zacatrus_url_composer.dart';

class ZacatrusBrowserState {
  const ZacatrusBrowserState({
    required this.urlComposer,
    required this.games,
    this.loadingFeedback,
  });

  final ZacatrusUrlBrowserComposer urlComposer;
  final List<GameOverview> games;
  final InternetFeedback? loadingFeedback;

  factory ZacatrusBrowserState.init() {
    return ZacatrusBrowserState(
        urlComposer: ZacatrusUrlBrowserComposer.init(), games: []);
  }

  ZacatrusBrowserState addGames(List<GameOverview> addedGames) {
    return copyWith(games: [...games, ...addedGames], loadingFeedback: null);
  }

  bool get isLoaded => loadingFeedback == null;


//<editor-fold desc="Data Methods">

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ZacatrusBrowserState &&
          runtimeType == other.runtimeType &&
          urlComposer == other.urlComposer &&
          games == other.games &&
          loadingFeedback == other.loadingFeedback);

  @override
  int get hashCode =>
      urlComposer.hashCode ^ games.hashCode ^ loadingFeedback.hashCode;

  @override
  String toString() {
    return 'ZacatrusUrlBrowserState{' ' urlComposer: $urlComposer,' +
        ' games: $games,' +
        ' loadingFeedback: $loadingFeedback,' +
        '}';
  }

  ZacatrusBrowserState copyWith({
    ZacatrusUrlBrowserComposer? urlComposer,
    List<GameOverview>? games,
    InternetFeedback? loadingFeedback,
  }) {
    return ZacatrusBrowserState(
      urlComposer: urlComposer ?? this.urlComposer,
      games: games ?? this.games,
      loadingFeedback: loadingFeedback,
    );
  }

//</editor-fold>
}
