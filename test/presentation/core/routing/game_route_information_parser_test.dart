import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zacatrusa/game_board/presentation/core/routing/game_route_information_parser.dart';
import 'package:zacatrusa/game_board/presentation/core/routing/games_routing_configuration.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/zacatrus_url_composer.dart';

class MockProviderRef extends Mock implements ProviderRef {}

void main() {
  MockProviderRef mockProviderRef = MockProviderRef();

  group("Parsing", () {
    group("Home", () {
      test("Si buscas filter works", () async {
        final parser = GameRouteInformationParser(mockProviderRef);

        final GamesRoutingConfiguration conf =
            await parser.parseRouteInformation(const RouteInformation(
                location: "/juegos-de-mesa/familiares.html"));

        final GamesRoutingConfiguration expected =
            GamesRoutingConfiguration.home(
                filterComposer: ZacatrusUrlBrowserComposer.fromUrl(
                    "/juegos-de-mesa/familiares.html"));

        expect(conf, expected);
      });
    });
  });
}
