import 'package:zacatrusa/game_board/zacatrus/domain/details_page/game_data_sheet.dart';

import 'game_overview_details.dart';
import 'images_carousel.dart';

class ZacatrusDetailsPageData {
  ZacatrusDetailsPageData(
      {this.imagesCarousel,
      required this.gameOverview,
      this.gameDescription,
      this.gameDataSheet});

  ImagesCarousel? imagesCarousel;
  GameOverviewDetails gameOverview;
  String? gameDescription;
  String? overviewDescription;
  GameDataSheet? gameDataSheet;
}
