import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/dom.dart' as dom;
import 'package:zacatrusa/core/string_helper.dart';
import 'package:zacatrusa/game_board/infrastructure/core/scrapping_failures.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/details_page/game_overview_details.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/details_page/images_carousel.dart';

import '../../../core/multiple_result.dart';
import '../../infrastructure/core/internet_feedback.dart';
import '../../infrastructure/http_loader.dart';
import '../domain/details_page/zacatrus_details_page_data.dart';

final zacatrusDetailsPageScrapperProvider =
    Provider((ref) => ZacatrusDetailsPageScapper(ref: ref));

class ZacatrusDetailsPageScapper {
  const ZacatrusDetailsPageScapper({
    required this.ref,
  });

  final ProviderRef ref;

  Stream<Either<InternetFeedback, ZacatrusDetailsPageData>> getGameDetails(
      String url) async* {
    final httpLoader = ref.read(httpLoaderProvider);
    final stream = httpLoader.getPage(url: url);

    final Stream<Either<InternetFeedback, ZacatrusDetailsPageData>>
        mappedStream = stream.map((result) {
      if (result.isRight()) {
        final dom.Document doc = result.getRight()!;
        final data = _parseDetailsPage(doc, url);
        return data;
      }

      return Left(result.getLeft()!);
    });

    yield* mappedStream;
  }

  Either<InternetFeedback, ZacatrusDetailsPageData> _parseDetailsPage(
      dom.Document doc, String url) {
    try {
      ZacatrusDetailsPageData pageData =
          ZacatrusDetailsPageData(gameOverview: GameOverviewDetails(link: url));
      final dom.Element mainContent = doc.getElementById("maincontent")!;

      pageData.gameOverview = _parseGameOverview(mainContent, url);
      pageData.imagesCarousel = _parseImageCarousel(mainContent);
      pageData.gameDescription = _parseGameDescription(doc);
      pageData.overviewDescription = _parseOverviewDescription(mainContent);

      return Right(pageData);
    } catch (_) {
      return Left(ParsingFailure(url: url));
    }
  }

  GameOverviewDetails _parseGameOverview(dom.Element mainContent, String url) {
    GameOverviewDetails detailsOverview = GameOverviewDetails(link: url);
    try {
      final productInfo =
          mainContent.getElementsByClassName("product-info-main").first;

      final nameElements = productInfo.getElementsByClassName("page-title");
      if (nameElements.isNotEmpty) {
        detailsOverview.name = nameElements[0].text.trim();
      }

      _getAvailable(productInfo, detailsOverview);
      _getRating(productInfo, detailsOverview);
      _getComments(productInfo, detailsOverview);
      _getPrice(productInfo, detailsOverview);
    } catch (_) {
      // No found
    }
    return detailsOverview;
  }

  void _getAvailable(
      dom.Element detailsElement, GameOverviewDetails gameOverview) {
    try {
      final availableResultElements =
          detailsElement.getElementsByClassName("stock available");
      if (availableResultElements.isNotEmpty) {
        final availableResultElement = availableResultElements.first;
        final spanElements = availableResultElement.children;
        if (spanElements.isNotEmpty) {
          gameOverview.available = spanElements[0].text;
        }
      }
    } catch (_) {
      //Not found
    }
  }

  void _getRating(
      dom.Element detailsElement, GameOverviewDetails gameOverview) {
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

  void _getComments(
      dom.Element detailsElement, GameOverviewDetails gameOverview) {
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

  void _getPrice(dom.Element detailsElement, GameOverviewDetails gameOverview) {
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

  ImagesCarousel? _parseImageCarousel(dom.Element mainContent) {
    try {
      List<CarouselItem> carouselItems = [];

      final List<dom.Element> elementsToAnalyze =
          mainContent.getElementsByClassName("product media")[0].children;

      final jsonScript1 = json.decode(elementsToAnalyze[3].text);
      final List<dynamic> jsonData =
          jsonScript1["[data-gallery-role=gallery-placeholder]"]
              ["mage/gallery/gallery"]["data"];

      for (Map carouselData in jsonData) {
        final item = CarouselItem(
          image: carouselData["full"],
          semantics: "Unánimo imagen ${carouselItems.length}",
          video: carouselData["videoUrl"],
          isMain: carouselData["isMain"],
        );
        carouselItems.add(item);
      }

      return ImagesCarousel(items: carouselItems);
    } catch (_) {
      // No found
    }
  }

  String? _parseGameDescription(dom.Document document) {
    try {
      dom.Element outerDiv = document.getElementById("description")!;
      dom.Element innerDiv = outerDiv.children[0];
      return innerDiv.text.trim();
    } catch (_) {
      // No found
    }
  }

  String? _parseOverviewDescription(dom.Element mainContent) {
    try {
      dom.Element outerDiv =
          mainContent.getElementsByClassName("product attribute overview")[0];
      dom.Element innerDiv = outerDiv.children[0];
      return innerDiv.text.trim();
    } catch (_) {
      // No found
    }
  }
}
