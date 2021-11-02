import 'package:flutter/cupertino.dart';

import '../../../../core/optional.dart';
import 'zacatrus_page_query_parameter.dart';
import 'zacatrus_path_modifier_arguments.dart';

@immutable
class ZacatrusUrlBrowserComposer {
  factory ZacatrusUrlBrowserComposer.init() {
    return const ZacatrusUrlBrowserComposer(
        productsPerPage: ZacatrusProductsPerPage(24),
        pageNum: ZacatrusPageIndex(1));
  }

  static const String rawUrl = "https://zacatrus.es/juegos-de-mesa.html";

  final ZacatrusProductsPerPage productsPerPage;
  final ZacatrusPageIndex pageNum;

  final ZacatrusLookingForFilter? lookingFor;

  String buildUrl() {
    String url = "$rawUrl?${pageNum.toParam()}${productsPerPage.toParam()}";

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
    Optional<ZacatrusLookingForFilter?>? lookingFor,
  }) {
    return ZacatrusUrlBrowserComposer(
      productsPerPage: productsPerPage ?? this.productsPerPage,
      pageNum: pageNum ?? this.pageNum,
      lookingFor:
          lookingFor?.isValid ?? false ? lookingFor!.value : this.lookingFor,
    );
  }
}
