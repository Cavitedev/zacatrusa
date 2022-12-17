import 'i_filter.dart';

class ZacatrusSiBuscasFilter implements ISingleFilter {
  @override
  final String value;

  const ZacatrusSiBuscasFilter({
    required this.value,
  });

  ZacatrusSiBuscasFilter.url({
    required String valueUrl,
  }) : value = categoriesUrl.keys.firstWhere((key) => categoriesUrl[key] == valueUrl);

  static Iterable<String> get categories => categoriesUrl.keys;

  static Map<String, String> categoriesUrl = {
    "Familiares": "familiares",
    "Cooperativo": "cooperativo",
    "Solitario": "solitario",
    "Para 2": "para_2",
    "Experiencia": "experiencia",
    "Experto": "experto",
    "Fiesta": "fiesta",
    "Narrativo": "narrativo",
    "Rápido": "rapido",
    "Infantil": "infantil",
    "Viaje": "viaje",
    "Eurogame": "eurogame",
    "Ameritrash": "ameritrash"
  };

  @override
  String? toUrl() {
    return categoriesUrl[value];
  }

  static bool isValidCategory(String category) {
    return categories.contains(category);
  }

  @override
  isValid() => isValidCategory(value);

  static String keyValue = "ocasiones";

  ZacatrusSiBuscasFilter.queryUrl({
    required String value,
  }) : value = categoriesQueryUrl.keys.firstWhere((key) => categoriesQueryUrl[key] == value);

  static Map<String, String> categoriesQueryUrl = {
    "Familiares": "1623",
    "Cooperativo": "1616",
    "Solitario": "499",
    "Para 2": "277",
    "Experiencia": "1618",
    "Fiesta": "1622",
    "Narrativo": "1619",
    "Rápido": "1617",
    "Infantil": "276",
    "Viaje": "1615",
    "Eurogame": "1633",
    "Ameritrash": "1632"
  };

  String toQueryParam() => "$keyValue=${categoriesQueryUrl[value]}&";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZacatrusSiBuscasFilter && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'ZacatrusSiBuscasFilter{value: $value}';
  }
}
