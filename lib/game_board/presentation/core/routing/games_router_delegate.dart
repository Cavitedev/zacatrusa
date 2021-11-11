import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/game_board/presentation/settings/settings_page.dart';

import '../../../application/browser/browser_notifier.dart';
import '../../game_details/game_details.dart';
import '../../games_browse/games_browse.dart';
import 'games_routing_configuration.dart';

final gamesRouterDelegateProvider = Provider((ref) => GamesRouterDelegate(ref));

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

  set currentConf(GamesRoutingConfiguration conf) {
    if (conf.filterComposer != null) {
      ref
          .read(browserNotifierProvider.notifier)
          .changeFilters(conf.filterComposer!);
    }
    _currentConf = conf;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        MaterialPage(key: const ValueKey("Games Browse"), child: GamesBrowse()),
        if (_currentConf.detailsGameUrl != null)
          MaterialPage(
              key: ValueKey(_currentConf.detailsGameUrl),
              child: GameDetails(
                url: _currentConf.detailsGameUrl!,
              )),
        if (_currentConf.settings)
          const MaterialPage(key: ValueKey("Settings"), child: SettingsPage())
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        return onPopRoute();
      },
    );
  }

  bool onPopRoute() {
    if (_currentConf.settings == true) {
      _currentConf.settings = false;
      notifyListeners();
      return true;
    } else if (_currentConf.detailsGameUrl != null) {
      _currentConf.detailsGameUrl = null;
      notifyListeners();
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
}
