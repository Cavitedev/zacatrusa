import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      return GamesRoutingConfiguration.home(ref: ref);
    }

    final String location = routeInformation.location!;

    if (location.endsWith("settings")) {
      return GamesRoutingConfiguration.settings();
    } else if (location.contains("juegos-de-mesa")) {
      return GamesRoutingConfiguration.home(
          filterComposer: ZacatrusUrlBrowserComposer.fromUrl(location),
          ref: ref);
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
