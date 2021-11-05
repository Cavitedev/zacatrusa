import 'package:flutter/foundation.dart';

import 'i_filter.dart';

class ZacatrusEdadesFilter implements IMultipleFilter {
  @override
  final List<String> values;

  const ZacatrusEdadesFilter({
    required this.values,
  });

  ZacatrusEdadesFilter.url({
    required String concatenatedValue,
  }) : values = concatenatedValue.split(",")
            .map((valueUrl) => categoriesUrl.keys
                .firstWhere((key) => categoriesUrl[key] == valueUrl))
            .toList(growable: false);

  static Iterable<String> get categories => categoriesUrl.keys;

  static Map<String, String> categoriesUrl = {
    "de 0 a 3 años": "91",
    "de 3 a 6 años": "93",
    "de 6 a 8 años": "73",
    "de 8 a 10 años": "72",
    "de 10 a 14 años": "71",
    "de 14 a 18 años": "70",
    "más de 18 años": "1614"
  };

  @override
  String? toUrl() {
    if (values.isEmpty) {
      return null;
    }

    String url = "edad=" +
        values.map((value) => categoriesUrl[value]!).fold(
            "", (previousValue, element) => previousValue + element + ",");
    return url.substring(0, url.length - 1);
  }

  static bool isValidCategory(String category) {
    return categories.contains(category);
  }

  @override
  isValid() =>
      values.every((value) => isValidCategory(value)) && _notRepeated();

  bool _notRepeated() => values.toSet().toList().length == values.length;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZacatrusEdadesFilter &&
          runtimeType == other.runtimeType &&
          listEquals(values, other.values);

  @override
  int get hashCode => values.hashCode;
}
