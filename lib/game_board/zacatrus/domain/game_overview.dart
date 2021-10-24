class GameOverview{

  GameOverview({
    this.name = "Error retrieving game",
    this.link,
    this.imageUrl,
    this.numberOfComments,
    this.stars,
    this.price,
  });

  String name;
  String? link;
  String? imageUrl;
  int? numberOfComments;
  double? stars;
  double? price;
}