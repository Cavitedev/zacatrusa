import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../zacatrus/application/browser/zacatrus_browser_notifier.dart';
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

  set currentConf(GamesRoutingConfiguration conf) {
    if (conf.filterComposer != null) {
      ref
          .read(zacatrusBrowserNotifierProvider.notifier)
          .changeFilters(conf.filterComposer!);
    }
    _currentConf = conf;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: const [
        MaterialPage(key: ValueKey("Games Browse"), child: GamesBrowse())
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        popRoute();

        return true;
      },
    );
  }

  @override
  Future<bool> popRoute() {
    if (_currentConf.settings == true) {
      _currentConf.settings = false;
      notifyListeners();
      return Future.value(true);
    } else if (_currentConf.detailsGame != null) {
      // _currentConf.detailsPage = null;
      notifyListeners();
      return Future.value(true);
    }
    return Future.value(false);
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
