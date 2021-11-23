//ignore_for_file: avoid_print
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

//This test that the amount of filters haven't changed
void main() {
  const rawUrl = "https://zacatrus.es/juegos-de-mesa.html";
  late List<dom.Element> collapsibleFilters;

  setUpAll(() async {
    http.Response response = await http.get(Uri.parse(rawUrl));
    final String body = utf8.decode(response.bodyBytes);
    final dom.Document document = parser.parse(body);
    collapsibleFilters = document.getElementById("narrow-by-list")!.children;
  });

  test("Filters were fetched", () {
    expect(collapsibleFilters.length, 11);
  });

  test("Fetch Si buscas", () async {
    dom.Element tematicaDiv = collapsibleFilters[0];

    final dom.Element ol = tematicaDiv.getElementsByTagName("ol")[0];
    final Map<String, String> siBuscas = _getLabelLinkCategories(ol);

    print(siBuscas);
    expect(siBuscas.length, 12);
  });

  test("Fetch categorias", () async {
    dom.Element categoriaDiv = collapsibleFilters[1];

    final dom.Element ul = categoriaDiv.getElementsByTagName("ul")[0];
    final Map<String, String> categorias = _getLabelLinkCategories(ul);

    print(categorias);
    expect(categorias.length, 5);
  });

  test("Fetch temáticas", () async {
    dom.Element tematicaDiv = collapsibleFilters[4];

    final dom.Element ol = tematicaDiv.getElementsByTagName("ol")[0];
    final Map<String, String> tematicas = _getLabelLinkCategories(ol);

    print(tematicas);
    expect(tematicas.length, 43);
  });

  test("Fetch edades", () async {
    dom.Element edadDiv = collapsibleFilters[6];

    final dom.Element ol = edadDiv.getElementsByTagName("ol")[0];

    final Map<String, String> edades =
        _getLabelLinkCategories(ol, isParameter: true);

    print(edades);
    expect(edades.length, 7);
  });

  test("Fetch Num jugadores", () async {
    dom.Element numJugadoresDiv = collapsibleFilters[7];

    final dom.Element ol = numJugadoresDiv.getElementsByTagName("ol")[0];

    final Map<String, String> numJugadores = _getLabelLinkCategories(ol);

    print(numJugadores);
    expect(numJugadores.length, 9);
  });

  test("Fetch Mecánica", () async {
    dom.Element mecanicaDiv = collapsibleFilters[9];

    final dom.Element ol = mecanicaDiv.getElementsByTagName("ol")[0];
    final Map<String, String> mecanicas = _getLabelLinkCategories(ol);

    print(mecanicas);
    expect(mecanicas.length, 35);
  });

  test("Fetch Editorial", () async {
    dom.Element editorialDiv = collapsibleFilters[10];

    final dom.Element ol = editorialDiv.getElementsByTagName("ol")[0];
    final Map<String, String> editoriales = _getLabelLinkCategories(ol);

    print(editoriales);
    expect(editoriales.length, 194);
  });
}

Map<String, String> _getLabelLinkCategories(dom.Element ol,
    {bool isParameter = false}) {
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
      late String urlModifier;
      if (isParameter) {
        urlModifier = link.substring(link.lastIndexOf("?") + 1);
      } else {
        final List<String> urlSplitted = link.split(RegExp("[/.]"));
        urlModifier = urlSplitted[urlSplitted.length - 2];
      }

      return MapEntry('"$label"', '"$urlModifier"');
    }).whereType<MapEntry<String, String>>(),
  );
}
