import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/game_board/zacatrus/application/browser/zacatrus_browser_notifier.dart';

import '../../../../core/string_helper.dart';
import '../../../zacatrus/domain/url/zacatrus_url_composer.dart';
import 'games_routing_configuration.dart';

final gameRouteInformationParserProvider =
    Provider((ref) => GameRouteInformationParser(ref));

class GameRouteInformationParser
    extends RouteInformationParser<GamesRoutingConfiguration> {
  final ProviderRef ref;

  GameRouteInformationParser(this.ref);

  @override
  Future<GamesRoutingConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    if (routeInformation.location == null || routeInformation.location == "/") {
      ref.read(zacatrusBrowserNotifierProvider.notifier).loadGames();
      return GamesRoutingConfiguration.home();
    }

    final String location = routeInformation.location!;

    if (location.endsWith("settings")) {
      return GamesRoutingConfiguration.settings();
    } else if (location.contains("juegos-de-mesa")) {
      final ZacatrusUrlBrowserComposer composer =
          ZacatrusUrlBrowserComposer.fromUrl(location);
      final result = GamesRoutingConfiguration.home(filterComposer: composer);
      return result;
    }

    String detailsGame = location.substring(
        location.lastIndexOf("/") + 1, location.lastIndexOf("."));
    return GamesRoutingConfiguration.details(detailsGame: detailsGame);
  }

  @override
  RouteInformation restoreRouteInformation(
      GamesRoutingConfiguration configuration) {
    if (configuration.isHome()) {
      return RouteInformation(
          location:
              configuration.filterComposer?.buildUrl().removeDomain() ?? "");
    } else if (configuration.settings == true) {
      return const RouteInformation(location: "settings");
    }
    return RouteInformation(location: configuration.detailsGame!);
  }
}
