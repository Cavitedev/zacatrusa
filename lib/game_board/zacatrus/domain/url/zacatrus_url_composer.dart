import 'package:flutter/cupertino.dart';

import '../../../../core/optional.dart';
import 'filters/zacatrus_categoria_filter.dart';
import 'filters/zacatrus_edades_filter.dart';
import 'filters/zacatrus_editorial_filter.dart';
import 'filters/zacatrus_mecanica_filter.dart';
import 'filters/zacatrus_num_jugadores_filter.dart';
import 'filters/zacatrus_page_query_parameter.dart';
import 'filters/zacatrus_rango_precio_filter.dart';
import 'filters/zacatrus_si_buscas_filter.dart';
import 'filters/zacatrus_tematica_filter.dart';

@immutable
class ZacatrusUrlBrowserComposer {
  const ZacatrusUrlBrowserComposer({
    required this.productsPerPage,
    required this.pageNum,
    this.siBuscas,
    this.categoria,
    this.tematica,
    this.edades,
    this.numJugadores,
    this.precio,
    this.mecanica,
    this.editorial,
  });

  factory ZacatrusUrlBrowserComposer.init() {
    return const ZacatrusUrlBrowserComposer(
        productsPerPage: ZacatrusProductsPerPage(24),
        pageNum: ZacatrusPageIndex(1));
  }

  static const String rawUrl = "https://zacatrus.es/juegos-de-mesa";

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

  String buildUrl() {
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

    final String pathUrl = '$rawUrl$categoriaAddition$pathJoin2.html';

    final String params =
        "${pageNum.toParam()}${productsPerPage.toParam()}${precio?.toUrl() ?? ""}${edades?.toUrl() ?? ""}";

    String url = "$pathUrl?$params";

    if (url[url.length - 1] == "&" || url[url.length - 1] == "?") {
      return url.substring(0, url.length - 1);
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ZacatrusUrlBrowserComposer &&
          runtimeType == other.runtimeType &&
          productsPerPage == other.productsPerPage &&
          pageNum == other.pageNum &&
          siBuscas == other.siBuscas);

  @override
  int get hashCode =>
      productsPerPage.hashCode ^ pageNum.hashCode ^ siBuscas.hashCode;

  @override
  String toString() {
    return 'ZacatrusUrlBrowserComposer{'
        ' productsPerPage: $productsPerPage,'
        ' pageNum: $pageNum,'
        ' lookingFor: $siBuscas,'
        '}';
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
    );
  }
}
