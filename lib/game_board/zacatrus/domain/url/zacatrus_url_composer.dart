import 'package:flutter/cupertino.dart';

import '../../../../core/optional.dart';
import 'filters/zacatrus_categoria_filter.dart';
import 'filters/zacatrus_edades_filter.dart';
import 'filters/zacatrus_editorial_filter.dart';
import 'filters/zacatrus_mecanica_filter.dart';
import 'filters/zacatrus_num_jugadores_filter.dart';
import 'filters/zacatrus_order.dart';
import 'filters/zacatrus_page_query_parameter.dart';
import 'filters/zacatrus_query_filter.dart';
import 'filters/zacatrus_rango_precio_filter.dart';
import 'filters/zacatrus_si_buscas_filter.dart';
import 'filters/zacatrus_tematica_filter.dart';

@immutable
class ZacatrusUrlBrowserComposer {
  final ZacatrusProductsPerPage productsPerPage;
  final ZacatrusPageIndex pageNum;

  final ZacatrusSiBuscasFilter? siBuscas;
  final ZacatrusCategoriaFilter? categoria;
  final ZacatrusTematicaFilter? tematica;
  final ZacatrusEdadesFilter? edades;
  final ZacatrusNumJugadoresFilter? numJugadores;
  final ZacatrusRangoPrecioFilter? precio;
  final ZacatrusMecanicaFilter? mecanica;
  final ZacatrusEditorialFilter? editorial;
  final ZacatrusOrder? order;
  final ZacatrusQueryFilter? query;

  const ZacatrusUrlBrowserComposer(
      {required this.productsPerPage,
      required this.pageNum,
      this.siBuscas,
      this.categoria,
      this.tematica,
      this.edades,
      this.numJugadores,
      this.precio,
      this.mecanica,
      this.editorial,
      this.order,
      this.query});

  factory ZacatrusUrlBrowserComposer.init() {
    return const ZacatrusUrlBrowserComposer(
        productsPerPage: ZacatrusProductsPerPage(24),
        pageNum: ZacatrusPageIndex(1));
  }

  static const String rawUrlNoQuery = "https://zacatrus.es/juegos-de-mesa";

  static const String rawUrlWithQuery =
      "https://zacatrus.es/catalogsearch/result/?";

  factory ZacatrusUrlBrowserComposer.fromUrl(String url) {
    url = url.replaceAll(".html", "");
    final Uri uri = Uri.parse(url);

    if (uri.pathSegments[0] == "juegos-de-mesa") {
      return ZacatrusUrlBrowserComposer._fromUriWithoutQuery(uri);
    } else {
      return ZacatrusUrlBrowserComposer._fromUriWithQuery(uri);
    }
  }

  factory ZacatrusUrlBrowserComposer._fromUriWithQuery(Uri uri) {
    ZacatrusProductsPerPage productsPerPage = const ZacatrusProductsPerPage(24);
    ZacatrusPageIndex pageNum = const ZacatrusPageIndex(1);
    ZacatrusSiBuscasFilter? siBuscas;
    ZacatrusCategoriaFilter? categoria;
    ZacatrusTematicaFilter? tematica;
    ZacatrusNumJugadoresFilter? numJugadores;
    ZacatrusRangoPrecioFilter? precio;
    ZacatrusMecanicaFilter? mecanica;
    ZacatrusOrder? order;

    ZacatrusQueryFilter? query;

    if (uri.queryParameters.isNotEmpty) {
      final String? queryParam = uri.queryParameters["q"];
      if (queryParam != null) {
        query = ZacatrusQueryFilter(value: queryParam);
      }

      final String? siBuscasParam =
          uri.queryParameters[ZacatrusSiBuscasFilter.keyValue];
      if (siBuscasParam != null) {
        siBuscas = ZacatrusSiBuscasFilter.queryUrl(value: siBuscasParam);
      }

      final String? tematicaParam =
          uri.queryParameters[ZacatrusTematicaFilter.keyValue];
      if (tematicaParam != null) {
        tematica = ZacatrusTematicaFilter.queryUrl(value: tematicaParam);
      }

      final String? numJugadoresParam =
          uri.queryParameters[ZacatrusNumJugadoresFilter.keyValue];
      if (numJugadoresParam != null) {
        numJugadores = ZacatrusNumJugadoresFilter.queryUrl(
            concatenatedValue: numJugadoresParam);
      }

      final String? mecanicaParam =
          uri.queryParameters[ZacatrusMecanicaFilter.keyValue];
      if (mecanicaParam != null) {
        mecanica = ZacatrusMecanicaFilter.queryUrl(value: mecanicaParam);
      }
    }

    return ZacatrusUrlBrowserComposer(
        pageNum: pageNum,
        productsPerPage: productsPerPage,
        siBuscas: siBuscas,
        categoria: categoria,
        numJugadores: numJugadores,
        mecanica: mecanica,
        precio: precio,
        tematica: tematica,
        order: order,
        query: query);
  }

  factory ZacatrusUrlBrowserComposer._fromUriWithoutQuery(Uri uri) {
    ZacatrusProductsPerPage productsPerPage = const ZacatrusProductsPerPage(24);
    ZacatrusPageIndex pageNum = const ZacatrusPageIndex(1);

    ZacatrusSiBuscasFilter? siBuscas;
    ZacatrusCategoriaFilter? categoria;
    ZacatrusTematicaFilter? tematica;
    ZacatrusEdadesFilter? edades;
    ZacatrusNumJugadoresFilter? numJugadores;
    ZacatrusRangoPrecioFilter? precio;
    ZacatrusMecanicaFilter? mecanica;
    ZacatrusEditorialFilter? editorial;
    ZacatrusOrder? order;

    if (uri.pathSegments.length == 1 && uri.queryParameters.isEmpty) {
      return ZacatrusUrlBrowserComposer.init();
    }

    if (uri.pathSegments.length > 1) {
      final String segment1 = uri.pathSegments[1];
      String? multipleFiltersSegmnet;
      if (ZacatrusCategoriaFilter.categoriesUrl.values.contains(segment1)) {
        categoria = ZacatrusCategoriaFilter.url(valueUrl: segment1);
      } else {
        multipleFiltersSegmnet = segment1;
      }

      if (uri.pathSegments.length == 3) {
        multipleFiltersSegmnet = uri.pathSegments[2];
      }

      if (multipleFiltersSegmnet != null) {
        //SiBuscas-Temática-numJugadores-numJugadores2...-mecanica-editorial
        final List<String> multiplesFiltersSegment =
            multipleFiltersSegmnet.split("-");

        final List<String> numJugadoresFound = [];
        //Filters always appear on that order, so once one is checked avoid checking it again
        int filterFound = -1;

        for (String filter in multiplesFiltersSegment) {
          if (filterFound < 0 &&
              ZacatrusSiBuscasFilter.categoriesUrl.values.contains(filter)) {
            siBuscas = ZacatrusSiBuscasFilter.url(valueUrl: filter);
            filterFound = 0;
          } else if (filterFound < 1 &&
              ZacatrusTematicaFilter.categoriesUrl.values.contains(filter)) {
            tematica = ZacatrusTematicaFilter.url(valueUrl: filter);
            filterFound = 1;
          } else if (filterFound <= 2 &&
              ZacatrusNumJugadoresFilter.categoriesUrl.values
                  .contains(filter)) {
            numJugadoresFound.add(filter);
            filterFound = 2;
          } else if (filterFound < 3 &&
              ZacatrusMecanicaFilter.categoriesUrl.values.contains(filter)) {
            mecanica = ZacatrusMecanicaFilter.url(valueUrl: filter);
            filterFound = 3;
          } else if (ZacatrusEditorialFilter.categoriesUrl.values
              .contains(filter)) {
            editorial = ZacatrusEditorialFilter.url(valueUrl: filter);
          }
        }
        if (numJugadoresFound.isNotEmpty) {
          numJugadores =
              ZacatrusNumJugadoresFilter.url(valuesUrl: numJugadoresFound);
        }
      }
    }

    if (uri.queryParameters.isNotEmpty) {
      final String? edad = uri.queryParameters["edad"];
      if (edad != null) {
        edades = ZacatrusEdadesFilter.url(concatenatedValue: edad);
      }

      final String? precioParam = uri.queryParameters["price"];
      if (precioParam != null) {
        precio = ZacatrusRangoPrecioFilter.url(precioParameter: precioParam);
      }

      final String? orderParam = uri.queryParameters["product_list_order"];
      if (orderParam != null) {
        final String? isDesc = uri.queryParameters["product_list_dir"];

        order = ZacatrusOrder.url(orderParam: orderParam, isDescParam: isDesc);
      }
    }

    return ZacatrusUrlBrowserComposer(
        pageNum: pageNum,
        productsPerPage: productsPerPage,
        siBuscas: siBuscas,
        numJugadores: numJugadores,
        categoria: categoria,
        edades: edades,
        editorial: editorial,
        mecanica: mecanica,
        precio: precio,
        tematica: tematica,
        order: order);
  }

  String buildUrl() {
    if (query == null) {
      return _buildUrlWithNoQuery();
    }

    String url =
        "$rawUrlWithQuery${mecanica?.toQueryParam() ?? ""}${numJugadores?.toQueryParam() ?? ""}${siBuscas?.toQueryParam() ?? ""}${query?.toParam() ?? ""}${tematica?.toQueryParam() ?? ""}";
    return _urlWithUnnecesaryCharacters(url);
  }

  String _buildUrlWithNoQuery() {
    String categoriaAddition =
        categoria == null ? "" : "/${categoria!.toUrl()}";

    final String siBuscasAddition = siBuscas?.toUrl() ?? "";

    final String tematicaAddition = tematica?.toUrl() ?? "";

    final String numJugadoresAddition = numJugadores?.toUrl() ?? "";

    final String mecanicaAddition = mecanica?.toUrl() ?? "";

    final String editorialAddition = editorial?.toUrl() ?? "";

    final String pathJoin2 = _joinPath([
      siBuscasAddition,
      tematicaAddition,
      numJugadoresAddition,
      mecanicaAddition,
      editorialAddition
    ]);

    final String pathUrl = '$rawUrlNoQuery$categoriaAddition$pathJoin2.html';

    final String params =
        "${pageNum.toParam()}${edades?.toUrl() ?? ""}${precio?.toUrl() ?? ""}${productsPerPage.toParam()}${order?.toUrl() ?? ""}";

    String url = "$pathUrl?$params";

    url = _urlWithUnnecesaryCharacters(url);

    return url;
  }

  String _urlWithUnnecesaryCharacters(String url) {
    if (url[url.length - 1] == "&" || url[url.length - 1] == "?") {
      url = url.substring(0, url.length - 1);
    }
    return url;
  }

  ZacatrusUrlBrowserComposer nextPage() {
    return copyWith(pageNum: pageNum.copyWithNextPage());
  }

  String _joinPath(List<String> elements) {
    final List<String> nonEmptyElements =
        elements.where((element) => element.isNotEmpty).toList();

    if (nonEmptyElements.isEmpty) {
      return "";
    }

    return "/" + nonEmptyElements.join("-");
  }

  bool get areThereFilters =>
      siBuscas != null ||
      categoria != null ||
      tematica != null ||
      edades != null ||
      numJugadores != null ||
      precio != null ||
      mecanica != null ||
      editorial != null;

  bool get canSearchBeComplete =>
      query == null || !areThereFiltersConflictingWithQueries;

  bool get areThereFiltersConflictingWithQueries =>
      categoria != null ||
      edades != null ||
      precio != null ||
      editorial != null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZacatrusUrlBrowserComposer &&
          runtimeType == other.runtimeType &&
          siBuscas == other.siBuscas &&
          categoria == other.categoria &&
          tematica == other.tematica &&
          edades == other.edades &&
          numJugadores == other.numJugadores &&
          precio == other.precio &&
          mecanica == other.mecanica &&
          editorial == other.editorial &&
          order == other.order &&
          query == other.query &&
          productsPerPage == other.productsPerPage &&
          pageNum == other.pageNum;

  @override
  int get hashCode =>
      siBuscas.hashCode ^
      categoria.hashCode ^
      tematica.hashCode ^
      edades.hashCode ^
      numJugadores.hashCode ^
      precio.hashCode ^
      mecanica.hashCode ^
      editorial.hashCode ^
      order.hashCode ^
      query.hashCode ^
      productsPerPage.hashCode ^
      pageNum.hashCode;

  @override
  String toString() {
    return 'ZacatrusUrlBrowserComposer{siBuscas: $siBuscas, categoria: $categoria, tematica: $tematica, edades: $edades, numJugadores: $numJugadores, precio: $precio, mecanica: $mecanica, editorial: $editorial, order: $order, query: $query, productsPerPage: $productsPerPage, pageNum: $pageNum}';
  }

  ZacatrusUrlBrowserComposer copyWith({
    ZacatrusProductsPerPage? productsPerPage,
    ZacatrusPageIndex? pageNum,
    Optional<ZacatrusSiBuscasFilter?>? siBuscas,
    Optional<ZacatrusCategoriaFilter?>? categoria,
    Optional<ZacatrusTematicaFilter?>? tematica,
    Optional<ZacatrusEdadesFilter?>? edades,
    Optional<ZacatrusNumJugadoresFilter?>? numJugadores,
    Optional<ZacatrusRangoPrecioFilter?>? precio,
    Optional<ZacatrusMecanicaFilter?>? mecanica,
    Optional<ZacatrusEditorialFilter?>? editorial,
    Optional<ZacatrusOrder?>? order,
    Optional<ZacatrusQueryFilter?>? query,
  }) {
    return ZacatrusUrlBrowserComposer(
      productsPerPage: productsPerPage ?? this.productsPerPage,
      pageNum: pageNum ?? this.pageNum,
      siBuscas: siBuscas?.isValid ?? false ? siBuscas!.value : this.siBuscas,
      categoria:
          categoria?.isValid ?? false ? categoria!.value : this.categoria,
      tematica: tematica?.isValid ?? false ? tematica!.value : this.tematica,
      edades: edades?.isValid ?? false ? edades!.value : this.edades,
      numJugadores: numJugadores?.isValid ?? false
          ? numJugadores!.value
          : this.numJugadores,
      precio: precio?.isValid ?? false ? precio!.value : this.precio,
      mecanica: mecanica?.isValid ?? false ? mecanica!.value : this.mecanica,
      editorial:
          editorial?.isValid ?? false ? editorial!.value : this.editorial,
      order: order?.isValid ?? false ? order!.value : this.order,
      query: query?.isValid ?? false ? query!.value : this.query,
    );
  }
}
