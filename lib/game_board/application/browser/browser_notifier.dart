import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/optional.dart';
import '../../infrastructure/core/scrapping_failures.dart';
import '../../zacatrus/domain/url/filters/zacatrus_page_query_parameter.dart';
import '../../zacatrus/domain/url/zacatrus_url_composer.dart';
import '../../zacatrus/infrastructure/zacatrus_browse_page_scrapper.dart';
import 'browser_state.dart';

final browserNotifierProvider =
    StateNotifierProvider<BrowserNotifier, BrowserState>((ref) =>
        BrowserNotifier(
            scrapper: ref.read(zacatrusBrowsePageScrapperProvider)));

class BrowserNotifier extends StateNotifier<BrowserState> {
  BrowserNotifier({
    required this.scrapper,
  }) : super(BrowserState.init());

  final ZacatrusBrowsePageScapper scrapper;
  StreamSubscription? subscription;

  void loadGames() {
    if (state.allGamesFetched) {
      state = state.copyWith(
          loadingFeedback:
              NoMoreGamesFailure(url: state.urlComposer.buildUrl()));
      return;
    }

    subscription?.cancel();
    subscription =
        scrapper.getGamesOverviews(state.urlComposer).listen((event) {
      event.when((left) {
        state = state.copyWith(loadingFeedback: event.getLeft()!);
      }, (right) {
        state = state
            .copyWith(
              urlComposer: state.urlComposer.nextPage(),
              gamesFound: state.gamesFound != null
                  ? null
                  : Optional.value(event.getRight()!.amount),
            )
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
    state = state.copyWith(
        games: [],
        gamesFound: const Optional.value(null),
        urlComposer:
            state.urlComposer.copyWith(pageNum: const ZacatrusPageIndex(1)));
    loadGames();
  }

  void changeFilters(ZacatrusUrlBrowserComposer composer) {
    if (state.urlComposer != composer) {
      state = state.copyWith(
          urlComposer: composer.copyWith(pageNum: const ZacatrusPageIndex(1)),
          games: [],
          gamesFound: const Optional.value(null),
          loadingFeedback: null);
      loadGames();
    }
  }
}
