import 'package:flutter/foundation.dart';

import 'i_filter.dart';

class ZacatrusNumJugadoresFilter implements IMultipleFilter {
  @override
  final List<String> values;

  const ZacatrusNumJugadoresFilter({
    required this.values,
  });

  ZacatrusNumJugadoresFilter.url({
    required List<String> valuesUrl,
  }) : values = valuesUrl
            .map((valueUrl) => categoriesUrl.keys
                .firstWhere((key) => categoriesUrl[key] == valueUrl))
            .toList(growable: false);

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

    String url = values
        .map((value) => categoriesUrl[value]!)
        .fold("", (previousValue, element) => previousValue + element + "-");
    return url.substring(0, url.length - 1);
  }

  static bool isValidCategory(String category) {
    return categories.contains(category);
  }

  @override
  isValid() =>
      values.every((value) => isValidCategory(value)) && _notRepeated();

  bool _notRepeated() => values.toSet().toList().length == values.length;

  static String keyValue = "njugadores";

  ZacatrusNumJugadoresFilter.queryUrl({
    required String concatenatedValue,
  }) : values = concatenatedValue
            .split(",")
            .map((valueUrl) => categoriesQueryUrl.keys
                .firstWhere((key) => categoriesQueryUrl[key] == valueUrl))
            .toList(growable: false);

  static Map<String, String> categoriesQueryUrl = {
    "1": "280",
    "2": "281",
    "3": "282",
    "4": "283",
    "5": "284",
    "6": "285",
    "7": "286",
    "8": "287",
    "+8": "308"
  };

  String toQueryParam() {
    String valueParam = values
        .map((value) => categoriesQueryUrl[value]!)
        .fold<String>(
            "", (previousValue, element) => previousValue + element + ",");
    valueParam = valueParam.substring(0, valueParam.length - 1);
    return "$keyValue=$valueParam&";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZacatrusNumJugadoresFilter &&
          runtimeType == other.runtimeType &&
          listEquals(values, other.values);

  @override
  int get hashCode => values.hashCode;
}
