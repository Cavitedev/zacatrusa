import '../../../domain/url/category_amount.dart';

class ZacatrusLookingForFilterOptions {
  const ZacatrusLookingForFilterOptions({
    required this.categoriesAmount,
  });

  final List<CategoryAmount> categoriesAmount;

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

  bool isValid() {
    return categoriesAmount
        .every((category) => categories.contains(category.name));
  }
}
