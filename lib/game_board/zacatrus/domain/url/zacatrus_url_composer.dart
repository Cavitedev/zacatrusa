
import 'package:zacatrusa/game_board/zacatrus/domain/url/zacatrus_page_query_parameter.dart';

class ZacatrusUrlBrowserComposer {


  ZacatrusUrlBrowserComposer({int page = 1, int productsPerPage = 24})
      : productsPerPage = ZacatrusPageProductPerPage(productsPerPage),
        pageNum = ZacatrusPageIndex(page);



  static const String rawUrl = "https://zacatrus.es/juegos-de-mesa.html";

  ZacatrusPageProductPerPage productsPerPage;
  ZacatrusPageIndex pageNum;

  String buildUrl() {
    String url = "$rawUrl?${pageNum.toParam()}${productsPerPage.toParam()}";

    if (url[url.length - 1] == "&" || url[url.length - 1] == "?") {
      return url.substring(0, url.length - 1);
    }

    return url;
  }

  void nextPage() {
    pageNum.value += 1;
  }
}
