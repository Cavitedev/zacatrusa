class ZacatrusLookingForFilter {
  final String? category;

  const ZacatrusLookingForFilter({
    this.category,
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


  isValid() =>
      category == null ||
      isValidCategory(category!);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZacatrusLookingForFilter &&
          runtimeType == other.runtimeType &&
          category == other.category;

  @override
  int get hashCode => category.hashCode;
}
