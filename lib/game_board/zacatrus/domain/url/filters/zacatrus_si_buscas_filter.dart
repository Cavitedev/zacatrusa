class ZacatrusSiBuscasFilter {
  final String value;

  const ZacatrusSiBuscasFilter({
    required this.value,
  });

    static List<String> categories = [
    "Familiares",
    "Cooperativo",
    "Solitario ",
    "Para 2",
    "Experiencia",
    "Fiesta",
    "Rápido",
    "Infantil",
    "Viaje",
    "Eurogame",
    "Ameritrash"
  ];

  static bool isValidCategory(String category) {
    return categories.contains(category);
  }


  isValid() => isValidCategory(value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZacatrusSiBuscasFilter &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
