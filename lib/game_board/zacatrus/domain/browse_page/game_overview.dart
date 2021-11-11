import '../../../domain/image_data.dart';

class GameOverview {
  GameOverview({
    this.name = "Error recuperando juego",
    this.link,
    this.image,
    this.numberOfReviews,
    this.stars,
    this.price,
  });

  String name;
  String? link;
  ImageData? image;
  int? numberOfReviews;
  double? stars;
  double? price;

  @override
  String toString() {
    return 'GameOverview{name: $name}';
  }
}
