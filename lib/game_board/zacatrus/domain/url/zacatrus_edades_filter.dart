class ZacatrusEdadesFilter {
  final List<String> values;

  const ZacatrusEdadesFilter({
    required this.values,
  });

  static List<String> categories = [
    "de 0 a 3 años",
    "de 3 a 6 años",
    "de 6 a 8 años",
    "de 8 a 10 años",
    "de 10 a 14 años",
    "de 14 a 18 años",
    "más de 18 años"
  ];

  static bool isValidCategory(String category) {
    return categories.contains(category);
  }

  isValid() =>
      values.every((value) => isValidCategory(value)) &&
          _notRepeated();

  bool _notRepeated() => values.toSet().toList().length == values.length;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZacatrusEdadesFilter &&
          runtimeType == other.runtimeType &&
          values == other.values;

  @override
  int get hashCode => values.hashCode;
}
