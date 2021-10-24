import 'package:zacatrusa/game_board/infrastructure/core/internet_feedback.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/game_overview.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/zacatrus_url_composer.dart';

class ZacatrusUrlBrowserState{

    const ZacatrusUrlBrowserState({
    required this.urlComposer,
    required this.games,
    required this.loadingFeedback,
  });

  final ZacatrusUrlBrowserComposer urlComposer;
  final List<GameOverview> games;
  final InternetFeedback loadingFeedback;

//<editor-fold desc="Data Methods">



  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ZacatrusUrlBrowserState &&
          runtimeType == other.runtimeType &&
          urlComposer == other.urlComposer &&
          games == other.games &&
          loadingFeedback == other.loadingFeedback);

  @override
  int get hashCode =>
      urlComposer.hashCode ^ games.hashCode ^ loadingFeedback.hashCode;

  @override
  String toString() {
    return 'ZacatrusUrlBrowserState{' +
        ' urlComposer: $urlComposer,' +
        ' games: $games,' +
        ' loadingFeedback: $loadingFeedback,' +
        '}';
  }

  ZacatrusUrlBrowserState copyWith({
    ZacatrusUrlBrowserComposer? urlComposer,
    List<GameOverview>? games,
    InternetFeedback? loadingFeedback,
  }) {
    return ZacatrusUrlBrowserState(
      urlComposer: urlComposer ?? this.urlComposer,
      games: games ?? this.games,
      loadingFeedback: loadingFeedback ?? this.loadingFeedback,
    );
  }


//</editor-fold>
}