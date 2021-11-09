import 'game_overview_details.dart';
import 'images_carousel.dart';

class ZacatrusDetailsPageData {
  ZacatrusDetailsPageData({
    this.imagesCarousel,
    required this.gameOverview,
    this.gameplayDetails,
  });

  ImagesCarousel? imagesCarousel;
  GameOverviewDetails gameOverview;
  String? gameplayDetails;
}
