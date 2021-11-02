class ZacatrusSiBuscasFilter {
  final String category;

  const ZacatrusSiBuscasFilter({
    required this.category,
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


  isValid() => isValidCategory(category);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZacatrusSiBuscasFilter &&
          runtimeType == other.runtimeType &&
          category == other.category;

  @override
  int get hashCode => category.hashCode;
}
