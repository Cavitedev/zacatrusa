class ZacatrusNumJugadoresFilter {
  final List<String> values;

  const ZacatrusNumJugadoresFilter({
    required this.values,
  });

  static List<String> categories = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "+8"
  ];

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
