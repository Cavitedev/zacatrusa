import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/game_board/zacatrus/application/browser/zacatrus_browser_notifier.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/zacatrus_url_composer.dart';

class GamesRoutingConfiguration {
  ZacatrusUrlBrowserComposer? _filterComposer;
  bool settings;
  String? detailsGame;

  GamesRoutingConfiguration.home({
    required ProviderRef ref,
    ZacatrusUrlBrowserComposer? filterComposer,
  })  : settings = false,
        detailsGame = null {
    setFilterComposer(filterComposer, ref);
  }

  GamesRoutingConfiguration.details({this.detailsGame})
      : _filterComposer = null,
        settings = false;

  GamesRoutingConfiguration.settings() : settings = true;

  ZacatrusUrlBrowserComposer? get filterComposer => _filterComposer;

  bool isHome() => settings == false && detailsGame == null;

  void setFilterComposer(
      ZacatrusUrlBrowserComposer? composer, ProviderRef ref) {
    if (composer != null) {
      ref
          .read(zacatrusBrowserNotifierProvider.notifier)
          .changeFilters(composer);
    }
    _filterComposer = composer;
  }
}
