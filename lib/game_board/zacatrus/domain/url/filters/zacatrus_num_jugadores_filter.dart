import 'i_filter.dart';

class ZacatrusNumJugadoresFilter implements IMultipleFilter {
  final List<String> values;

  const ZacatrusNumJugadoresFilter({
    required this.values,
  });

  static Iterable<String> get categories => categoriesUrl.keys;

  static Map<String, String> categoriesUrl = {
    "1": "1",
    "2": "2",
    "3": "3",
    "4": "4",
    "5": "5",
    "6": "6",
    "7": "7",
    "8": "8_1",
    "+8": "8"
  };

  @override
  String? toUrl() {
    if (values.isEmpty) {
      return null;
    }

    String url =
        values.map((value) => categoriesUrl[value]!).fold(
            "", (previousValue, element) => previousValue + element + "-");
    return url.substring(0, url.length - 1);
  }

  static bool isValidCategory(String category) {
    return categories.contains(category);
  }

  isValid() =>
      values.every((value) => isValidCategory(value)) && _notRepeated();

  bool _notRepeated() => values.toSet().toList().length == values.length;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZacatrusNumJugadoresFilter &&
          runtimeType == other.runtimeType &&
          values == other.values;

  @override
  int get hashCode => values.hashCode;
}
