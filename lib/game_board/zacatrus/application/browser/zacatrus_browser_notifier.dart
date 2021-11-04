import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_page_query_parameter.dart';

import '../../domain/url/zacatrus_url_composer.dart';
import '../../infrastructure/zacatrus_scrapper.dart';
import 'zacatrus_browser_state.dart';

final zacatrusBrowserNotifierProvider =
    StateNotifierProvider<ZacatrusBrowserNotifier, ZacatrusBrowserState>(
        (ref) => ZacatrusBrowserNotifier(
            scrapper: ref.read(zacatrusScrapperProvider)));

class ZacatrusBrowserNotifier extends StateNotifier<ZacatrusBrowserState> {
  ZacatrusBrowserNotifier({
    required this.scrapper,
  }) : super(ZacatrusBrowserState.init());

  final ZacatrusScapper scrapper;
  StreamSubscription? subscription;

  void loadGames() {
    subscription?.cancel();
    subscription =
        scrapper.getGamesOverviews(state.urlComposer).listen((event) {
      event.when((left) {
        state = state.copyWith(loadingFeedback: event.getLeft()!);
      }, (right) {
        state = state
            .copyWith(urlComposer: state.urlComposer.nextPage())
            .addGames(event.getRight()!.games);
      });
    })
          ..onDone(() {
            subscription = null;
          });
  }

  /// Retrieves next page if it is not loading any page
  void nextPageIfNotLoading() {
    if (subscription == null) {
      loadGames();
    }
  }

  void clear() {
    state = state.copyWith(games: [], urlComposer: state.urlComposer.copyWith(pageNum: const ZacatrusPageIndex(1)));
    loadGames();
  }

  void changeFilters(ZacatrusUrlBrowserComposer composer) {
    state =
        state.copyWith(urlComposer: composer, games: [], loadingFeedback: null);
    loadGames();
  }
}
