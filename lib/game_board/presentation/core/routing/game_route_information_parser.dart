import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/string_helper.dart';
import '../../../application/browser/browser_notifier.dart';
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
      ref.read(browserNotifierProvider.notifier).loadGames();
      return GamesRoutingConfiguration.home();
    }

    final String location = routeInformation.location!;

    if (location.endsWith("settings")) {
      return GamesRoutingConfiguration.settings();
    } else if (location.endsWith("dice")) {
      return GamesRoutingConfiguration.dice();
    } else if (location.contains("juegos-de-mesa") ||
        location.contains("catalogsearch")) {
      final ZacatrusUrlBrowserComposer composer =
          ZacatrusUrlBrowserComposer.fromUrl(location);
      final result = GamesRoutingConfiguration.home(filterComposer: composer);
      return result;
    }

    String detailsGame = "https://zacatrus.es$location";
    return GamesRoutingConfiguration.details(detailsGameUrl: detailsGame);
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
    } else if (configuration.dice == true) {
      return const RouteInformation(location: "dice");
    }
    return RouteInformation(location: configuration.detailsGameUrl!);
  }
}
