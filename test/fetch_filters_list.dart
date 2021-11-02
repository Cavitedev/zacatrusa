//ignore_for_file: avoid_print
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

//This is to automate fetching the filters from the page, this does not test code
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

  test("Fetch categorias", () async {
    dom.Element categoriaDiv = collapsibleFilters[1];

    final dom.Element ul = categoriaDiv.getElementsByTagName("ul")[0];
    final List<String> categorias = ul.children
        .map((child) => child.attributes["data-label"] == null
            ? null
            : '"${child.attributes["data-label"]}"')
        .whereType<String>()
        .toList();

    print(categorias);
    expect(categorias.length, 5);
  });

  test("Fetch temáticas", () async {
    dom.Element tematicaDiv = collapsibleFilters[4];

    final dom.Element ol = tematicaDiv.getElementsByTagName("ol")[0];
    final Map<String, String> tematicas =
        Map.fromEntries(ol.children.map((child) {
      final String? label = child.attributes["data-label"];
      final String? link = child.children[0].attributes["href"];
      if (label == null || link == null) {
        return null;
      }
      final List<String> urlSplitted = link.split(RegExp("[\/\.]"));
      final String urlModifier = urlSplitted[urlSplitted.length - 2];
      return MapEntry('"$label"', '"$urlModifier"');
    }).whereType<MapEntry<String, String>>());

    print(tematicas);
    expect(tematicas.length, 43);
  });

  test("Fetch edades", () async {
    dom.Element edadDiv = collapsibleFilters[6];

    final dom.Element ol = edadDiv.getElementsByTagName("ol")[0];
    final List<String> edades = ol.children
        .map((child) => child.attributes["data-label"] == null
            ? null
            : '"${child.attributes["data-label"]}"')
        .whereType<String>()
        .toList();

    print(edades);
    expect(edades.length, 7);
  });

  test("Fetch Num jugadores", () async {
    dom.Element numJugadoresDiv = collapsibleFilters[7];

    final dom.Element ol = numJugadoresDiv.getElementsByTagName("ol")[0];
    final List<String> numJugadores = ol.children
        .map((child) => child.attributes["data-label"] == null
            ? null
            : '"${child.attributes["data-label"]}"')
        .whereType<String>()
        .toList();

    print(numJugadores);
    expect(numJugadores.length, 9);
  });

  test("Fetch Mecánica", () async {
    dom.Element mecanicaDiv = collapsibleFilters[9];

    final dom.Element ol = mecanicaDiv.getElementsByTagName("ol")[0];
    final List<String> mecanicas = ol.children
        .map((child) => child.attributes["data-label"] == null
            ? null
            : '"${child.attributes["data-label"]}"')
        .whereType<String>()
        .toList();

    print(mecanicas);
    expect(mecanicas.length, 35);
  });

  test("Fetch Editorial", () async {
    dom.Element editorialDiv = collapsibleFilters[10];

    final dom.Element ol = editorialDiv.getElementsByTagName("ol")[0];
    final List<String> editoriales = ol.children
        .map((child) => child.attributes["data-label"] == null
            ? null
            : '"${child.attributes["data-label"]}"')
        .whereType<String>()
        .toList();

    print(editoriales);
    expect(editoriales.length, 189);
  });
}
