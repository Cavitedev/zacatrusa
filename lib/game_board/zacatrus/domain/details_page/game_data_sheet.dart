class GameDataSheet {
  GameDataSheet({
    this.authors,
    this.bgg,
    this.mechanic,
    this.theme,
    this.siBuscas,
    this.ageRanges,
    this.numPlayers,
    this.gameplayDuration,
    this.measurements,
    this.complexity,
    this.editorial,
    this.content,
    this.language,
    this.languageDependency,
  });

  String? authors;
  int? bgg;
  String? mechanic;
  String? theme;
  String? siBuscas;
  String? ageRanges;
  String? numPlayers;
  String? gameplayDuration;
  String? measurements;
  String? complexity;
  String? editorial;
  List<String>? content;
  String? language;
  String? languageDependency;
}
