import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/dom.dart' as dom;

import '../../../core/multiple_result.dart';
import '../../../core/string_helper.dart';
import '../../domain/image_data.dart';
import '../../infrastructure/core/internet_feedback.dart';
import '../../infrastructure/http_loader.dart';
import '../domain/game_overview.dart';
import '../domain/url/zacatrus_url_composer.dart';
import '../domain/zacatrus_browse_page_data.dart';
import 'zacatrus_browse_failures.dart';

final zacatrusScrapperProvider = Provider((ref) => ZacatrusScapper(ref: ref));

class ZacatrusScapper {
  const ZacatrusScapper({
    required this.ref,
  });

  final ProviderRef ref;

  Stream<Either<InternetFeedback, ZacatrusBrowsePageData>> getGamesOverviews(
      ZacatrusUrlBrowserComposer urlComposer) async* {
    final httpLoader = ref.read(httpLoaderProvider);
    final String url = urlComposer.buildUrl();
    final stream = httpLoader.getPage(url: url);

    final Stream<Either<InternetFeedback, ZacatrusBrowsePageData>>
        mappedStream = stream.map((result) {
      if (result.isRight()) {
        final dom.Document doc = result.getRight()!;
        final data = _parseBrowserPage(doc, url);
        return data;
      }

      return Left(result.getLeft()!);
    });

    yield* mappedStream;
  }

  static const String _idDivAllProductsData = "amasty-shopby-product-list";
  static const String _productItems = "product-items";
  static const String _itemDetails = "product-item-details";
  static const String _itemDetailsName = "product-item-name";

  Either<InternetFeedback, ZacatrusBrowsePageData> _parseBrowserPage(
      dom.Document doc, String url) {
    final shopListDiv = doc.getElementById(_idDivAllProductsData);
    if (shopListDiv == null) {
      return Left(ParsingFailure(url: url));
    }

    try {
      if (shopListDiv.getElementsByClassName("message info empty").isNotEmpty) {
        return Left(NoGamesFailure(url: url));
      }

      final int? amount = _parseAmountGames(shopListDiv);

      final gameListDom =
          shopListDiv.getElementsByClassName(_productItems).first;
      final List<GameOverview> games = _parseGameList(gameListDom);

      final ZacatrusBrowsePageData data = ZacatrusBrowsePageData(
        games: games,
        amount: amount,
      );

      return Right(data);
    } catch (_) {
      return Left(ParsingFailure(url: url));
    }
  }

  int? _parseAmountGames(dom.Element productListDiv) {
    try {
      final dom.Element toolbarAmount =
          productListDiv.getElementsByClassName("toolbar-amount")[0];

      final dom.Element totalGamesAmountElement = toolbarAmount.children.last;

      return int.parse(totalGamesAmountElement.text);
    } catch (_) {
      // No found
    }
  }

  List<GameOverview> _parseGameList(dom.Element gamesListDom) {
    final List<GameOverview> gamesRetrieved = [];
    final liChildren =
        gamesListDom.children.where((element) => element.localName == "li");

    for (final liGameList in liChildren) {
      gamesRetrieved.add(_addGameOverviewFromDiv(liGameList.children.first));
    }

    return gamesRetrieved;
  }

  GameOverview _addGameOverviewFromDiv(dom.Element divWithGame) {
    final GameOverview gameOverview =
        GameOverview(name: "Error retrieving name");
    try {
      final anchorElement = divWithGame.children
          .firstWhere((element) => element.localName == "a");
      gameOverview.link = anchorElement.attributes["href"];

      dom.Element imageElement =
          anchorElement.getElementsByTagName("img").first;
      String? imageLink = imageElement.attributes["src"];
      String? imageAlt = imageElement.attributes["alt"];
      gameOverview.image = ImageData(imageLink: imageLink, imageAlt: imageAlt);
    } catch (_) {
      // Not found
    }

    try {
      final detailsElement = divWithGame.children
          .firstWhere((element) => element.classes.contains(_itemDetails));

      _getName(detailsElement, gameOverview);

      _getRating(detailsElement, gameOverview);

      _getComments(detailsElement, gameOverview);

      _getPrice(detailsElement, gameOverview);
    } catch (_) {
      // Not found
    }

    return gameOverview;
  }

  void _getName(dom.Element detailsElement, GameOverview gameOverview) {
    try {
      final nameLinkElements =
          detailsElement.getElementsByClassName(_itemDetailsName);
      if (nameLinkElements.isNotEmpty) {
        final nameLinkElement = nameLinkElements.first;
        gameOverview.name = nameLinkElement.text.trim();
        gameOverview.link ??= nameLinkElement.attributes["href"];
      }
    } catch (_) {
      //Not found
    }
  }

  void _getRating(dom.Element detailsElement, GameOverview gameOverview) {
    try {
      final ratingResultElements =
          detailsElement.getElementsByClassName("rating-result");
      if (ratingResultElements.isNotEmpty) {
        final ratingResultElement = ratingResultElements.first;
        final String? titleTag = ratingResultElement.attributes["title"];
        if (titleTag != null) {
          gameOverview.stars = titleTag.toNum() / 20.0;
        }
      }
    } catch (_) {
      //Not found
    }
  }

  void _getComments(dom.Element detailsElement, GameOverview gameOverview) {
    try {
      final commentsElements =
          detailsElement.getElementsByClassName("reviews-actions");
      if (commentsElements.isNotEmpty) {
        final commentsElement = commentsElements.first.children.first;
        final String comments = commentsElement.text;

        gameOverview.numberOfComments = comments.toNum().toInt();
      }
    } catch (_) {
      //Not found
    }
  }

  void _getPrice(dom.Element detailsElement, GameOverview gameOverview) {
    try {
      final priceElements = detailsElement.getElementsByClassName("price");
      if (priceElements.isNotEmpty) {
        final priceElement = priceElements.first;
        final String priceText = priceElement.text;

        gameOverview.price = priceText.fromCommaDecimalToNum();
      }
    } catch (_) {
      //Not found
    }
  }
}
