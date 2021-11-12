class GameReview {
  GameReview({
    this.title,
    this.stars,
    this.description,
    this.author,
    this.date,
  });

  String? title;
  double? stars;
  String? description;
  String? author;
  String? date;

  /// Checks for reviews with no data
  bool isValid() {
    return isElementValid(title) || isElementValid(description);
  }

  static bool isElementValid(String? element) {
    return element != null && element.isNotEmpty && element != "*";
  }
}
