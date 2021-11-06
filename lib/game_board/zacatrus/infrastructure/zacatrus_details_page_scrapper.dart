import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/dom.dart' as dom;
import 'package:zacatrusa/game_board/infrastructure/core/scrapping_failures.dart';
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
      ZacatrusDetailsPageData pageData = ZacatrusDetailsPageData();
      final dom.Element mainContent = doc.getElementById("maincontent")!;

      pageData.imagesCarousel = _parseImageCarousel(mainContent);
      return Right(pageData);
    } catch (_) {
      return Left(ParsingFailure(url: url));
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
}
