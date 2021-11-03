import 'package:flutter_test/flutter_test.dart';
import 'package:zacatrusa/core/optional.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_categoria_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_edades_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_num_jugadores_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_page_query_parameter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_si_buscas_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_tematica_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/zacatrus_url_composer.dart';

void main() {
  group("Build urls", () {
    test("Initial class returns default page with 24 elements", () {
      final urlComposer = ZacatrusUrlBrowserComposer.init();

      final output = urlComposer.buildUrl();

      expect(output, "https://zacatrus.es/juegos-de-mesa.html");
    });

    test("Initial class with next page returns default page with 24 elements",
        () {
      var urlComposer = ZacatrusUrlBrowserComposer.init();
      urlComposer = urlComposer.nextPage();

      final output = urlComposer.buildUrl();

      expect(output, "https://zacatrus.es/juegos-de-mesa.html?p=2");
    });

    test("Initial class with 36 elements returns basic browser", () {
      final urlComposer = ZacatrusUrlBrowserComposer.init()
          .copyWith(productsPerPage: const ZacatrusProductsPerPage(36));

      final output = urlComposer.buildUrl();

      expect(output,
          "https://zacatrus.es/juegos-de-mesa.html?product_list_limit=36");
    });

    test('Initial class with "Si buscas" Familiares returns right url', () {
      final urlComposer = ZacatrusUrlBrowserComposer.init().copyWith(
          lookingFor: const Optional.value(
              ZacatrusSiBuscasFilter(value: "Familiares")));

      final output = urlComposer.buildUrl();

      expect(output, "https://zacatrus.es/juegos-de-mesa/familiares.html");
    });

    test('Initial class with "Si Buscas" Para 2 returns right url', () {
      final urlComposer = ZacatrusUrlBrowserComposer.init().copyWith(
          lookingFor:
              const Optional.value(ZacatrusSiBuscasFilter(value: "Para 2")));

      final output = urlComposer.buildUrl();

      expect(output, "https://zacatrus.es/juegos-de-mesa/para_2.html");
    });

    test('Categoria returns right url', () {
      final urlComposer = ZacatrusUrlBrowserComposer.init().copyWith(
          categoria: const Optional.value(
              ZacatrusCategoriaFilter(value: "Juegos de tablero")));

      final output = urlComposer.buildUrl();

      expect(output, "https://zacatrus.es/juegos-de-mesa/tablero.html");
    });

    test('Categoria and si buscas returns right url', () {
      final urlComposer = ZacatrusUrlBrowserComposer.init().copyWith(
          lookingFor:
              const Optional.value(ZacatrusSiBuscasFilter(value: "Para 2")),
          categoria: const Optional.value(
              ZacatrusCategoriaFilter(value: "Juegos de tablero")));

      final output = urlComposer.buildUrl();

      expect(output, "https://zacatrus.es/juegos-de-mesa/tablero/para_2.html");
    });

    test('Tematica returns right url', () {
      final urlComposer = ZacatrusUrlBrowserComposer.init().copyWith(
          tematica:
              const Optional.value(ZacatrusTematicaFilter(value: "Abstracto")));

      final output = urlComposer.buildUrl();

      expect(output, "https://zacatrus.es/juegos-de-mesa/abstracto.html");
    });

    test('Tematica, Si buscas, categoria returns right url', () {
      final urlComposer = ZacatrusUrlBrowserComposer.init().copyWith(
          lookingFor:
              const Optional.value(ZacatrusSiBuscasFilter(value: "Para 2")),
          categoria: const Optional.value(
              ZacatrusCategoriaFilter(value: "Juegos de tablero")),
          tematica:
              const Optional.value(ZacatrusTematicaFilter(value: "Abstracto")));

      final output = urlComposer.buildUrl();

      expect(output,
          "https://zacatrus.es/juegos-de-mesa/tablero/para_2-abstracto.html");
    });

    test('Edades returns right url', () {
      final urlComposer = ZacatrusUrlBrowserComposer.init().copyWith(
          edades: const Optional.value(ZacatrusEdadesFilter(values: [
        "de 0 a 3 años",
        "de 3 a 6 años",
      ])));

      final output = urlComposer.buildUrl();

      expect(output, "https://zacatrus.es/juegos-de-mesa.html?edad=91,93");
    });

    test('NumJugadores returns right url', () {
      final urlComposer = ZacatrusUrlBrowserComposer.init().copyWith(
          numJugadores:
              const Optional.value(ZacatrusNumJugadoresFilter(values: [
        "8",
        "+8",
      ])));

      final output = urlComposer.buildUrl();

      expect(output, "https://zacatrus.es/juegos-de-mesa/8_1-8.html");
    });
  });
}
