class ZacatrusCategoriaFilter {
  final String value;

  const ZacatrusCategoriaFilter({
    required this.value,
  });

  static List<String> categories = [
    "Juegos de tablero",
    "Juegos de cartas",
    "Wargames",
    "Juegos de miniaturas",
    "Juegos de dados",
  ];

  static Map<String, String> urlMapping = {
    "Juegos de tablero": "tablero",
    "Juegos de cartas": "cartas",
    "Wargames": "wargames",
    "Juegos de miniaturas": "juegos-de-miniaturas",
    "Juegos de dados": "dados",
  };

  static bool isValidCategory(String category) {
    return categories.contains(category);
  }

  isValid() => isValidCategory(value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZacatrusCategoriaFilter &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
