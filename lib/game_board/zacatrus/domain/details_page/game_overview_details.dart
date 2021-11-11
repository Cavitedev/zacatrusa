class GameOverviewDetails {
  GameOverviewDetails({
    this.name = "Error recuperando juego",
    required this.link,
    this.available,
    this.numberOfReviews,
    this.stars,
    this.price,
  });

  String name;
  String link;
  String? available;
  int? numberOfReviews;
  double? stars;
  double? price;

  @override
  String toString() {
    return 'GameOverview{name: $name}';
  }
}
