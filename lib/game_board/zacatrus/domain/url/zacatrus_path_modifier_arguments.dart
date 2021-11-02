import '../filters/zacatrus_looking_for_filter_options.dart';

class ZacatrusLookingForFilter {
  final String? category;

  const ZacatrusLookingForFilter({
    this.category,
  });

  isValid() =>
      category == null ||
      ZacatrusLookingForFilterOptions.isValidCategory(category!);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZacatrusLookingForFilter &&
          runtimeType == other.runtimeType &&
          category == other.category;

  @override
  int get hashCode => category.hashCode;
}
