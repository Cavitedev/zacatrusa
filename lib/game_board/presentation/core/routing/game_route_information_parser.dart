import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/string_helper.dart';
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
    return GamesRoutingConfiguration.home(ref: ref);
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
    return RouteInformation(location: configuration.detailsPage!);
  }
}
