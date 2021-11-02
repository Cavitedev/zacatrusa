import 'package:flutter/cupertino.dart';
import 'package:zacatrusa/core/string_helper.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/zacatrus_categoria_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/zacatrus_tematica_filter.dart';

import '../../../../core/optional.dart';
import 'zacatrus_page_query_parameter.dart';
import 'zacatrus_si_buscas_filter.dart';

@immutable
class ZacatrusUrlBrowserComposer {
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

  String buildUrl() {
    final String categoriaAddition = categoria == null
        ? ""
        : "/${ZacatrusCategoriaFilter.urlMapping[categoria!.value]}";

    final String siBuscasAddition = lookingFor == null
        ? ""
        : "/${lookingFor!.value.toUrlValidCharacters()}";
    final String pathUrl = '$rawUrl$categoriaAddition$siBuscasAddition.html';

    String url = "$pathUrl?${pageNum.toParam()}${productsPerPage.toParam()}";

    if (url[url.length - 1] == "&" || url[url.length - 1] == "?") {
      return url.substring(0, url.length - 1);
    }

    return url;
  }

  ZacatrusUrlBrowserComposer nextPage() {
    return copyWith(pageNum: pageNum.copyWithNextPage());
  }

  const ZacatrusUrlBrowserComposer({
    required this.productsPerPage,
    required this.pageNum,
    this.lookingFor,
    this.categoria,
    this.tematica,
  });

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
  }) {
    return ZacatrusUrlBrowserComposer(
      productsPerPage: productsPerPage ?? this.productsPerPage,
      pageNum: pageNum ?? this.pageNum,
      lookingFor:
          lookingFor?.isValid ?? false ? lookingFor!.value : this.lookingFor,
      categoria:
          categoria?.isValid ?? false ? categoria!.value : this.categoria,
      tematica: tematica?.isValid ?? false ? tematica!.value : this.tematica,
    );
  }
}
