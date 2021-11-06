import '../../../domain/image_data.dart';

class GameOverview {
  GameOverview({
    this.name = "Error recuperando juego",
    this.link,
    this.image,
    this.numberOfComments,
    this.stars,
    this.price,
  });

  String name;
  String? link;
  ImageData? image;
  int? numberOfComments;
  double? stars;
  double? price;

  @override
  String toString() {
    return 'GameOverview{name: $name}';
  }
}
