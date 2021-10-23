class GameOverview{

  const GameOverview({
    required this.name,
    this.imageUrl,
    this.numberOfComments,
    this.stars,
    this.price,
  });

  final String name;
  final String? imageUrl;
  final int? numberOfComments;
  final double? stars;
  final double? price;
}