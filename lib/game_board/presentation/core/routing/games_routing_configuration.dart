import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/game_board/zacatrus/application/browser/zacatrus_browser_notifier.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/zacatrus_url_composer.dart';

class GamesRoutingConfiguration {
  ZacatrusUrlBrowserComposer? _filterComposer;
  bool settings;
  String? detailsPage;

  GamesRoutingConfiguration.home({
    required ProviderRef ref,
    ZacatrusUrlBrowserComposer? filterComposer,
  })  : settings = false,
        detailsPage = null {
    setFilterComposer(filterComposer, ref);
  }

  GamesRoutingConfiguration.id({this.detailsPage})
      : _filterComposer = null,
        settings = false;

  ZacatrusUrlBrowserComposer? get filterComposer => _filterComposer;

  bool isHome() => settings == false && detailsPage == null;

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
