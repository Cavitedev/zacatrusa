import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/game_board/zacatrus/application/browser/zacatrus_browser_state.dart';
import 'package:zacatrusa/game_board/zacatrus/infrastructure/zacatrus_scrapper.dart';

final zacatrusBrowserNotifierProvider =
    StateNotifierProvider<ZacatrusBrowserNotifier, ZacatrusBrowserState>(
        (ref) => ZacatrusBrowserNotifier(
            scrapper: ref.read(zacatrusScrapperProvider)));

class ZacatrusBrowserNotifier extends StateNotifier<ZacatrusBrowserState> {
  ZacatrusBrowserNotifier({
    required this.scrapper,
  }) : super(ZacatrusBrowserState.init()) {
    loadGames();
  }

  final ZacatrusScapper scrapper;
  StreamSubscription? subscription;

  void loadGames() {
    subscription ??=
        scrapper.getGamesOverviews(state.urlComposer).listen((event) {
      event.when((left) {
        state = state.copyWith(loadingFeedback: event.getLeft()!);
      }, (right) {
        state = state.addGames(event.getRight()!);
      });
    });

    subscription?.onDone(() {
      subscription = null;
    });
  }

  void nextPage() {
    state = state.copyWith(urlComposer: state.urlComposer.nextPage());
    loadGames();
  }

  void clear() {
    state = ZacatrusBrowserState.init();
    loadGames();
  }
}
