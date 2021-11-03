import 'i_filter.dart';

class ZacatrusCategoriaFilter implements ISingleFilter {

  @override
  final String value;

  const ZacatrusCategoriaFilter({
    required this.value,
  });

  static Iterable<String> get categories => categoriesUrl.keys;

  static Map<String, String> categoriesUrl = {
    "Juegos de tablero": "tablero",
    "Juegos de cartas": "cartas",
    "Wargames": "wargames",
    "Juegos de miniaturas": "juegos-de-miniaturas",
    "Juegos de dados": "dados",
  };

  @override
  String? toUrl() => categoriesUrl[value];

  static bool isValidCategory(String category) {
    return categories.contains(category);
  }

  @override
  bool isValid() => isValidCategory(value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZacatrusCategoriaFilter &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
