import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/dom.dart' as dom;

import '../../../core/multiple_result.dart';
import '../../domain/core/string_helper.dart';
import '../../infrastructure/core/internet_feedback.dart';
import '../../infrastructure/http_loader.dart';
import '../domain/game_overview.dart';
import '../domain/url/zacatrus_url_composer.dart';

final zacatrusScrapperProvider = Provider((ref) => ZacatrusScapper(ref: ref));

class ZacatrusScapper {
  const ZacatrusScapper({
    required this.ref,
  });

  final ProviderRef ref;

  Stream<Either<InternetFeedback, List<GameOverview>>> getGamesOverviews(
      ZacatrusUrlBrowserComposer urlComposer) async* {
    final httpLoader = ref.read(httpLoaderProvider);
    final stream = httpLoader.getPage(url: urlComposer.buildUrl());

    final Stream<Either<InternetFeedback, List<GameOverview>>> mappedStream =
        stream.map((result) {
      if (result.isRight()) {
        final dom.Document doc = result.getRight()!;
        final games = _parseBrowserPage(doc);
        return Right(games);
      }

      return Left(result.getLeft()!);
    });

    yield* mappedStream;
  }

  static const String _idDivAllProductsData = "amasty-shopby-product-list";
  static const String _productItems = "product-items";
  static const String _itemDetails = "product-item-details";
  static const String _itemDetailsName = "product-item-name";

  List<GameOverview> _parseBrowserPage(dom.Document doc) {
    final shopListDiv = doc.getElementById(_idDivAllProductsData);
    if (shopListDiv == null) {
      return [];
    }

    final gameListDom = shopListDiv.getElementsByClassName(_productItems).first;

    return _parseGameList(gameListDom);
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
      gameOverview.imageUrl =
          anchorElement.getElementsByTagName("img").first.attributes["src"];
    } on Exception {
      // Not found
    }

    try {
      final detailsElement = divWithGame.children
          .firstWhere((element) => element.classes.contains(_itemDetails));

      _getName(detailsElement, gameOverview);

      _getRating(detailsElement, gameOverview);

      _getComments(detailsElement, gameOverview);

      _getPrice(detailsElement, gameOverview);
    } on Exception {
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
    } on Exception {
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
    } on Exception {
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
    } on Exception {
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
    } on Exception {
      //Not found
    }
  }
}
