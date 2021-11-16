import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/zacatrus_url_composer.dart';
import 'package:zacatrusa/settings/media_query.dart';

import '../../../application/browser/browser_notifier.dart';
import '../../game_details/game_details.dart';
import '../../games_browse/games_browse.dart';
import '../../settings/settings_page.dart';
import '../widgets/slide_page.dart';
import 'games_routing_configuration.dart';

final gamesRouterDelegateProvider = Provider((ref) => GamesRouterDelegate(ref));
final isSearchingProvider = StateProvider<bool>((ref) => false);

class GamesRouterDelegate extends RouterDelegate<GamesRoutingConfiguration>
    with
        ChangeNotifier,
        PopNavigatorRouterDelegateMixin<GamesRoutingConfiguration> {
  GamesRouterDelegate(this.ref)
      : navigatorKey = GlobalKey<NavigatorState>(),
        _currentConf = GamesRoutingConfiguration.home();

  @override
  GlobalKey<NavigatorState> navigatorKey;

  final ProviderRef ref;

  GamesRoutingConfiguration _currentConf;

  GamesRoutingConfiguration get currentConf => _currentConf;

  final HeroController heroC = HeroController();

  set currentConf(GamesRoutingConfiguration conf) {
    if (conf.filterComposer != null && conf.isHome()) {
      _reloadInitPage(conf);
    }
    _currentConf = conf;
    notifyListeners();
  }

  void updateIsSearching(bool newIsSearching) {
    _currentConf = currentConf.copyWith(isSearching: newIsSearching);
    ref.read(isSearchingProvider.notifier).state = newIsSearching;
  }

  void _reloadInitPage(GamesRoutingConfiguration conf) {
    ref
        .read(browserNotifierProvider.notifier)
        .changeFilters(conf.filterComposer!);
  }

  @override
  Widget build(BuildContext context) {
    return UpdatedMediaQuery(
      child: Navigator(
        pages: [
          MaterialPage(
              key: const ValueKey("Games Browse"), child: GamesBrowse()),
          if (_currentConf.detailsGameUrl != null)
            MaterialPage(
                key: ValueKey(_currentConf.detailsGameUrl),
                child: GameDetails(
                  url: _currentConf.detailsGameUrl!,
                )),
          if (_currentConf.settings)
            const MaterialPage(
                key: ValueKey("Settings"), child: SettingsPage()),
          if (_currentConf.imageLoaded != null)
            MaterialPage(
                key: ValueKey("Image ${_currentConf.imageLoaded}"),
                child: SlidePage(
                  url: _currentConf.imageLoaded,
                ))
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }

          return onPopRoute();
        },
      ),
    );
  }

  bool onPopRoute() {
    if (_currentConf.imageLoaded != null) {
      _currentConf.imageLoaded = null;
      _loadInitHomeIfNeeded();

      notifyListeners();
      return true;
    } else if (_currentConf.settings == true) {
      _currentConf.settings = false;
      _loadInitHomeIfNeeded();
      notifyListeners();
      return true;
    } else if (_currentConf.detailsGameUrl != null) {
      _currentConf.detailsGameUrl = null;
      _loadInitHomeIfNeeded();
      notifyListeners();
      return true;
    } else if (_currentConf.isSearching) {
      _loadInitHomeIfNeeded();
      updateIsSearching(false);
      return true;
    }
    return false;
  }

  @override
  Future<bool> popRoute() {
    return Future.value(onPopRoute());
  }

  @override
  Future<void> setNewRoutePath(
    GamesRoutingConfiguration configuration,
  ) async {
    currentConf = configuration;
    notifyListeners();
    return Future.value(null);
  }

  void _loadInitHomeIfNeeded() {
    if (_currentConf.isHome() && _currentConf.filterComposer == null) {
      _currentConf.filterComposer = ZacatrusUrlBrowserComposer.init();
      ref.read(browserNotifierProvider.notifier).loadGames();
    }
  }
}
