import 'package:flutter_test/flutter_test.dart';
import 'package:zacatrusa/core/optional.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_categoria_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_edades_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_editorial_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_mecanica_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_num_jugadores_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_order.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_page_query_parameter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_query_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_rango_precio_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_si_buscas_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_tematica_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/zacatrus_url_composer.dart';

void main() {
  group("Build urls", () {
    group("Without search query", () {
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
            siBuscas: const Optional.value(
                ZacatrusSiBuscasFilter(value: "Familiares")));

        final output = urlComposer.buildUrl();

        expect(output, "https://zacatrus.es/juegos-de-mesa/familiares.html");
      });

      test('Initial class with "Si Buscas" Para 2 returns right url', () {
        final urlComposer = ZacatrusUrlBrowserComposer.init().copyWith(
            siBuscas:
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
            siBuscas:
                const Optional.value(ZacatrusSiBuscasFilter(value: "Para 2")),
            categoria: const Optional.value(
                ZacatrusCategoriaFilter(value: "Juegos de tablero")));

        final output = urlComposer.buildUrl();

        expect(
            output, "https://zacatrus.es/juegos-de-mesa/tablero/para_2.html");
      });

      test('Tematica returns right url', () {
        final urlComposer = ZacatrusUrlBrowserComposer.init().copyWith(
            tematica: const Optional.value(
                ZacatrusTematicaFilter(value: "Abstracto")));

        final output = urlComposer.buildUrl();

        expect(output, "https://zacatrus.es/juegos-de-mesa/abstracto.html");
      });

      test('Tematica, Si buscas, categoria returns right url', () {
        final urlComposer = ZacatrusUrlBrowserComposer.init().copyWith(
            siBuscas:
                const Optional.value(ZacatrusSiBuscasFilter(value: "Para 2")),
            categoria: const Optional.value(
                ZacatrusCategoriaFilter(value: "Juegos de tablero")),
            tematica: const Optional.value(
                ZacatrusTematicaFilter(value: "Abstracto")));

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

      test('Precio returns right url', () {
        final urlComposer = ZacatrusUrlBrowserComposer.init().copyWith(
            precio: const Optional.value(
                ZacatrusRangoPrecioFilter(min: 89, max: 203)));

        final output = urlComposer.buildUrl();

        expect(output,
            "https://zacatrus.es/juegos-de-mesa.html?price=89.00-203.00");
      });

      test('Mecanica returns right url', () {
        final urlComposer = ZacatrusUrlBrowserComposer.init().copyWith(
            mecanica: const Optional.value(
                ZacatrusMecanicaFilter(value: "Deducción e Investigación")));

        final output = urlComposer.buildUrl();

        expect(output,
            "https://zacatrus.es/juegos-de-mesa/deduccion_e_investigacion.html");
      });

      test('Editorial returns right url', () {
        final urlComposer = ZacatrusUrlBrowserComposer.init().copyWith(
            editorial:
                const Optional.value(ZacatrusEditorialFilter(value: "Ankama")));

        final output = urlComposer.buildUrl();

        expect(output, "https://zacatrus.es/juegos-de-mesa/ankama.html");
      });

      test('Order returns right url', () {
        final urlComposer = ZacatrusUrlBrowserComposer.init().copyWith(
            order: const Optional.value(ZacatrusOrder(
                value: ZacatrusOrderValues.ratingValue, isDesc: true)));

        final output = urlComposer.buildUrl();

        expect(output,
            "https://zacatrus.es/juegos-de-mesa.html?product_list_dir=desc&product_list_order=rating_summary");
      });

      test(
          'Si buscas, temática, num jugadores, mecánica, editorial returns right url',
          () {
        final urlComposer = ZacatrusUrlBrowserComposer.init().copyWith(
            siBuscas: const Optional.value(
                ZacatrusSiBuscasFilter(value: "Familiares")),
            tematica:
                const Optional.value(ZacatrusTematicaFilter(value: "Animales")),
            categoria: const Optional.value(
                ZacatrusCategoriaFilter(value: "Juegos de tablero")),
            mecanica: const Optional.value(
                ZacatrusMecanicaFilter(value: "Colección de sets")),
            editorial:
                const Optional.value(ZacatrusEditorialFilter(value: "Devir")),
            numJugadores: const Optional.value(ZacatrusNumJugadoresFilter(
                values: ["1", "2", "3", "4", "5", "6", "7", "8", "+8"])));

        final output = urlComposer.buildUrl();

        expect(output,
            "https://zacatrus.es/juegos-de-mesa/tablero/familiares-animales-1-2-3-4-5-6-7-8_1-8-coleccion_de_sets-devir.html");
      });
    });

    group("With search query", () {
      test("Searching only with query returns right url", () {
        final urlComposer = ZacatrusUrlBrowserComposer.init().copyWith(
            query: const Optional.value(ZacatrusQueryFilter(value: "cartas")));

        final output = urlComposer.buildUrl();

        expect(output, "https://zacatrus.es/catalogsearch/result/?q=cartas");
      });
    });
  });

  group("Build composer from url", () {
    test("home page returns init composer", () {
      const String url = "https://zacatrus.es/juegos-de-mesa.html";

      final result = ZacatrusUrlBrowserComposer.fromUrl(url);
      expect(result, ZacatrusUrlBrowserComposer.init());
    });

    test("home page with si buscas returns right composer", () {
      const String url = "https://zacatrus.es/juegos-de-mesa/familiares.html";

      final result = ZacatrusUrlBrowserComposer.fromUrl(url);
      expect(
          result,
          ZacatrusUrlBrowserComposer.init().copyWith(
              siBuscas: const Optional.value(
                  ZacatrusSiBuscasFilter(value: "Familiares"))));
    });

    test("home page with categoria returns right composer", () {
      const String url = "https://zacatrus.es/juegos-de-mesa/tablero.html";

      final result = ZacatrusUrlBrowserComposer.fromUrl(url);
      expect(
          result,
          ZacatrusUrlBrowserComposer.init().copyWith(
              categoria: const Optional.value(
                  ZacatrusCategoriaFilter(value: "Juegos de tablero"))));
    });

    test("home page with categoria and si buscas returns right composer", () {
      const String url =
          "https://zacatrus.es/juegos-de-mesa/tablero/para_2.html";

      final result = ZacatrusUrlBrowserComposer.fromUrl(url);
      expect(
          result,
          ZacatrusUrlBrowserComposer.init().copyWith(
              categoria: const Optional.value(
                  ZacatrusCategoriaFilter(value: "Juegos de tablero")),
              siBuscas: const Optional.value(
                  ZacatrusSiBuscasFilter(value: "Para 2"))));
    });

    test("home page with Tematica returns right composer", () {
      const String url =
          "https://zacatrus.es/juegos-de-mesa/arte_literatura.html";

      final result = ZacatrusUrlBrowserComposer.fromUrl(url);
      expect(
          result,
          ZacatrusUrlBrowserComposer.init().copyWith(
              tematica: const Optional.value(
                  ZacatrusTematicaFilter(value: "Arte y Literatura"))));
    });

    test("home page with num jugadores returns right composer", () {
      const String url = "https://zacatrus.es/juegos-de-mesa/3-4-5.html";

      final result = ZacatrusUrlBrowserComposer.fromUrl(url);
      expect(
          result,
          ZacatrusUrlBrowserComposer.init().copyWith(
              numJugadores: const Optional.value(
                  ZacatrusNumJugadoresFilter(values: ["3", "4", "5"]))));
    });

    test("home page with Mecánica returns right composer", () {
      const String url = "https://zacatrus.es/juegos-de-mesa/4x.html";

      final result = ZacatrusUrlBrowserComposer.fromUrl(url);
      expect(
          result,
          ZacatrusUrlBrowserComposer.init().copyWith(
              mecanica:
                  const Optional.value(ZacatrusMecanicaFilter(value: "4X"))));
    });

    test("home page with Editorial returns right composer", () {
      const String url = "https://zacatrus.es/juegos-de-mesa/zacatrus.html";

      final result = ZacatrusUrlBrowserComposer.fromUrl(url);
      expect(
          result,
          ZacatrusUrlBrowserComposer.init().copyWith(
              editorial: const Optional.value(
                  ZacatrusEditorialFilter(value: "Zacatrus"))));
    });

    test(
        "Mixed filter si buscas, categoria, num jugadores, tematica and editorial returns right composer",
        () {
      final urlComposer = ZacatrusUrlBrowserComposer.fromUrl(
          "https://zacatrus.es/juegos-de-mesa/tablero/familiares-animales-1-2-3-4-5-6-7-8_1-8-coleccion_de_sets-devir.html");
      final urlComposerExpected = ZacatrusUrlBrowserComposer.init().copyWith(
          siBuscas:
              const Optional.value(ZacatrusSiBuscasFilter(value: "Familiares")),
          tematica:
              const Optional.value(ZacatrusTematicaFilter(value: "Animales")),
          categoria: const Optional.value(
              ZacatrusCategoriaFilter(value: "Juegos de tablero")),
          mecanica: const Optional.value(
              ZacatrusMecanicaFilter(value: "Colección de sets")),
          editorial:
              const Optional.value(ZacatrusEditorialFilter(value: "Devir")),
          numJugadores: const Optional.value(ZacatrusNumJugadoresFilter(
              values: ["1", "2", "3", "4", "5", "6", "7", "8", "+8"])));

      expect(urlComposer, urlComposerExpected);
    });

    test("home page with edades returns right composer", () {
      const String url = "https://zacatrus.es/juegos-de-mesa.html?edad=93%2C73";

      final result = ZacatrusUrlBrowserComposer.fromUrl(url);
      expect(
          result,
          ZacatrusUrlBrowserComposer.init().copyWith(
              edades: const Optional.value(ZacatrusEdadesFilter(
                  values: ["de 3 a 6 años", "de 6 a 8 años"]))));
    });

    test("home page with sorting returns right composer", () {
      const String url =
          "https://zacatrus.es/juegos-de-mesa.html?product_list_order=rating_summary";

      final result = ZacatrusUrlBrowserComposer.fromUrl(url);
      expect(
          result,
          ZacatrusUrlBrowserComposer.init().copyWith(
              order: const Optional.value(ZacatrusOrder(
                  value: ZacatrusOrderValues.ratingValue, isDesc: false))));
    });

    test("home page with precio returns right composer", () {
      const String url =
          "https://zacatrus.es/juegos-de-mesa.html?price=181.00-270.00";

      final result = ZacatrusUrlBrowserComposer.fromUrl(url);
      expect(
          result,
          ZacatrusUrlBrowserComposer.init().copyWith(
              precio: const Optional.value(
                  ZacatrusRangoPrecioFilter(min: 181, max: 270))));
    });
  });

  group("From url to composer and from composer to url", () {
    test("Full case 1", () {
      const givenUrl =
          "https://zacatrus.es/juegos-de-mesa/dados/fiesta-abstracto-habilidad-asmodee.html?edad=73%2C72%2C71%2C70%2C1614&price=8.00-25.00&product_list_dir=desc&product_list_order=price";

      final composer = ZacatrusUrlBrowserComposer.fromUrl(givenUrl);
      final builtUrl = composer.buildUrl();

      final expectedUrl = Uri.decodeFull(givenUrl);
      expect(builtUrl, expectedUrl);
    });
  });
}
