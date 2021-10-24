import 'package:flutter/cupertino.dart';

import 'zacatrus_page_query_parameter.dart';

@immutable
class ZacatrusUrlBrowserComposer {
  ZacatrusUrlBrowserComposer({int page = 1, int productsPerPage = 24})
      : productsPerPage = ZacatrusPageProductPerPage(productsPerPage),
        pageNum = ZacatrusPageIndex(page);

  factory ZacatrusUrlBrowserComposer.init() {
    return const ZacatrusUrlBrowserComposer._(
        productsPerPage: ZacatrusPageProductPerPage(24),
        pageNum: ZacatrusPageIndex(1));
  }

  static const String rawUrl = "https://zacatrus.es/juegos-de-mesa.html";

  final ZacatrusPageProductPerPage productsPerPage;
  final ZacatrusPageIndex pageNum;

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


  const ZacatrusUrlBrowserComposer._({
    required this.productsPerPage,
    required this.pageNum,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ZacatrusUrlBrowserComposer &&
          runtimeType == other.runtimeType &&
          productsPerPage == other.productsPerPage &&
          pageNum == other.pageNum);

  @override
  int get hashCode => productsPerPage.hashCode ^ pageNum.hashCode;

  ZacatrusUrlBrowserComposer copyWith({
    ZacatrusPageProductPerPage? productsPerPage,
    ZacatrusPageIndex? pageNum,
  }) {
    return ZacatrusUrlBrowserComposer._(
      productsPerPage: productsPerPage ?? this.productsPerPage,
      pageNum: pageNum ?? this.pageNum,
    );
  }


}
