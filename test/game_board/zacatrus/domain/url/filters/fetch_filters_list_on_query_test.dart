//ignore_for_file: avoid_print
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_mecanica_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_num_jugadores_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_si_buscas_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_tematica_filter.dart';

//This test that the amount of filters haven't changed
void main() {
  const rawUrl = "https://zacatrus.es/catalogsearch/result/index/?q=cartas";
  late List<dom.Element> collapsibleFilters1;
  late List<dom.Element> collapsibleFilters2;

  setUpAll(() async {
    collapsibleFilters1 = await _parseWebsiteAndGetFilters(rawUrl);
    collapsibleFilters2 = await _parseWebsiteAndGetFilters(
        "https://zacatrus.es/catalogsearch/result/index/?q=musica");
  });

  test("Filters were fetched", () {
    expect(collapsibleFilters1.length, 7);
  });

  test("Fetch Si buscas", () async {
    dom.Element siBUscasDiv = collapsibleFilters1[0];

    final dom.Element ol = siBUscasDiv.getElementsByTagName("ol")[0];
    final Map<String, String> siBuscas =
        _getParameterLinkCategories(ol, ZacatrusSiBuscasFilter.keyValue);

    print(siBuscas);
    expect(siBuscas.length, 13);
  });

  test("Fetch temáticas", () async {
    dom.Element tematicaDiv = collapsibleFilters1[3];

    final dom.Element ol = tematicaDiv.getElementsByTagName("ol")[0];
    final Map<String, String> tematicas =
        _getParameterLinkCategories(ol, ZacatrusTematicaFilter.keyValue);

    dom.Element tematicaDiv2 = collapsibleFilters2[3];

    final dom.Element ol2 = tematicaDiv2.getElementsByTagName("ol")[0];
    final Map<String, String> tematicas2 =
        _getParameterLinkCategories(ol2, ZacatrusTematicaFilter.keyValue);

    tematicas.addAll(tematicas2);

    print(tematicas);
    expect(tematicas.length, 43);
  });

  test("Fetch Num jugadores", () async {
    dom.Element numJugadoresDiv = collapsibleFilters1[5];

    final dom.Element ol = numJugadoresDiv.getElementsByTagName("ol")[0];

    final Map<String, String> numJugadores =
        _getParameterLinkCategories(ol, ZacatrusNumJugadoresFilter.keyValue);

    print(numJugadores);
    expect(numJugadores.length, 9);
  });

  test("Fetch Mecánica", () async {
    dom.Element mecanicaDiv = collapsibleFilters1[6];

    final dom.Element ol = mecanicaDiv.getElementsByTagName("ol")[0];
    final Map<String, String> mecanicas =
        _getParameterLinkCategories(ol, ZacatrusMecanicaFilter.keyValue);

    print(mecanicas);
    expect(mecanicas.length, 36);
  });
}

Future<List<dom.Element>> _parseWebsiteAndGetFilters(String rawUrl) async {
  http.Response response = await http.get(Uri.parse(rawUrl));
  final String body = utf8.decode(response.bodyBytes);
  final dom.Document document = parser.parse(body);
  return document.getElementById("narrow-by-list")!.children;
}

Map<String, String> _getParameterLinkCategories(
    dom.Element ol, String parameter) {
  return Map.fromEntries(
    ol.children.map((child) {
      final String? label = child.attributes["data-label"];
      if (label == null) {
        return null;
      }
      final String? link = child.children[0].attributes["href"];
      if (link == null) {
        return null;
      }
      String urlModifier = Uri.parse(link).queryParameters[parameter]!;
      return MapEntry('"$label"', '"$urlModifier"');
    }).whereType<MapEntry<String, String>>(),
  );
}
