import 'package:flutter/cupertino.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_categoria_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_edades_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_tematica_filter.dart';

import '../../../../core/optional.dart';
import 'filters/zacatrus_page_query_parameter.dart';
import 'filters/zacatrus_si_buscas_filter.dart';

@immutable
class ZacatrusUrlBrowserComposer {
  const ZacatrusUrlBrowserComposer(
      {required this.productsPerPage,
      required this.pageNum,
      this.lookingFor,
      this.categoria,
      this.tematica,
      this.edades});

  factory ZacatrusUrlBrowserComposer.init() {
    return const ZacatrusUrlBrowserComposer(
        productsPerPage: ZacatrusProductsPerPage(24),
        pageNum: ZacatrusPageIndex(1));
  }

  static const String rawUrl = "https://zacatrus.es/juegos-de-mesa";

  final ZacatrusProductsPerPage productsPerPage;
  final ZacatrusPageIndex pageNum;

  final ZacatrusSiBuscasFilter? lookingFor;
  final ZacatrusCategoriaFilter? categoria;
  final ZacatrusTematicaFilter? tematica;
  final ZacatrusEdadesFilter? edades;

  String buildUrl() {
    String categoriaAddition = categoria?.toUrl() ?? "";
    if (categoriaAddition.isNotEmpty) {
      categoriaAddition = "/" + categoriaAddition;
    }

    String siBuscasAddition =
        lookingFor == null ? "" : "/${lookingFor!.toUrl()}";

    String tematicaAddition = tematica?.toUrl() ?? "";
    if (tematicaAddition.isNotEmpty) {
      if (siBuscasAddition.isNotEmpty) {
        tematicaAddition = "-" + tematicaAddition;
      } else {
        tematicaAddition = "/" + tematicaAddition;
      }
    }

    final String pathUrl =
        '$rawUrl$categoriaAddition$siBuscasAddition$tematicaAddition.html';

    String url = "$pathUrl?${pageNum.toParam()}${productsPerPage.toParam()}${edades?.toUrl() ?? ""}";

    if (url[url.length - 1] == "&" || url[url.length - 1] == "?") {
      return url.substring(0, url.length - 1);
    }

    return url;
  }

  ZacatrusUrlBrowserComposer nextPage() {
    return copyWith(pageNum: pageNum.copyWithNextPage());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ZacatrusUrlBrowserComposer &&
          runtimeType == other.runtimeType &&
          productsPerPage == other.productsPerPage &&
          pageNum == other.pageNum &&
          lookingFor == other.lookingFor);

  @override
  int get hashCode =>
      productsPerPage.hashCode ^ pageNum.hashCode ^ lookingFor.hashCode;

  @override
  String toString() {
    return 'ZacatrusUrlBrowserComposer{'
        ' productsPerPage: $productsPerPage,'
        ' pageNum: $pageNum,'
        ' lookingFor: $lookingFor,'
        '}';
  }

  ZacatrusUrlBrowserComposer copyWith({
    ZacatrusProductsPerPage? productsPerPage,
    ZacatrusPageIndex? pageNum,
    Optional<ZacatrusSiBuscasFilter?>? lookingFor,
    Optional<ZacatrusCategoriaFilter?>? categoria,
    Optional<ZacatrusTematicaFilter?>? tematica,
    Optional<ZacatrusEdadesFilter?>? edades,
  }) {
    return ZacatrusUrlBrowserComposer(
      productsPerPage: productsPerPage ?? this.productsPerPage,
      pageNum: pageNum ?? this.pageNum,
      lookingFor:
          lookingFor?.isValid ?? false ? lookingFor!.value : this.lookingFor,
      categoria:
          categoria?.isValid ?? false ? categoria!.value : this.categoria,
      tematica: tematica?.isValid ?? false ? tematica!.value : this.tematica,
      edades: edades?.isValid ?? false ? edades!.value : this.edades,
    );
  }
}
