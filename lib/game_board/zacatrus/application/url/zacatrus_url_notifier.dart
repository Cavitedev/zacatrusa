import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/zacatrus_url_composer.dart';

final zacatrusUrlBrowserNotifierProvider = StateNotifierProvider<
        ZacatrusUrlBrowserNotifier, ZacatrusUrlBrowserComposer>(
    (ref) => ZacatrusUrlBrowserNotifier(ZacatrusUrlBrowserComposer()));

class ZacatrusUrlBrowserNotifier
    extends StateNotifier<ZacatrusUrlBrowserComposer> {
  ZacatrusUrlBrowserNotifier(ZacatrusUrlBrowserComposer state) : super(state);

  void nextPage() {
    state.nextPage();
  }
}
