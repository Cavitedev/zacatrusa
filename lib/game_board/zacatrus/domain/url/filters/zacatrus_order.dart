import 'i_filter.dart';

enum ZacatrusOrderValues {
  bestSellers,
  price,
  newest,
  reviewCount,
  ratingValue
}

class ZacatrusOrder implements IFilter {
  const ZacatrusOrder({
    required this.value,
    required this.isDesc,
  });

  factory ZacatrusOrder.url({required String orderParam, String? isDescParam}) {
    bool isDesc = isDescParam == "desc";
    ZacatrusOrderValues order = categoriesUrl.keys
        .firstWhere((key) => categoriesUrl[key] == orderParam);
    return ZacatrusOrder(value: order, isDesc: isDesc);
  }

  final ZacatrusOrderValues value;
  final bool isDesc;

  static Map<ZacatrusOrderValues, String> categoriesUrl = {
    ZacatrusOrderValues.bestSellers: "bestsellers",
    ZacatrusOrderValues.price: "price",
    ZacatrusOrderValues.newest: "new",
    ZacatrusOrderValues.reviewCount: "reviews_count",
    ZacatrusOrderValues.ratingValue: "rating_summary",
  };

  @override
  bool isValid() {
    return true;
  }

  @override
  String? toUrl() {
    return "product_list_dir=${isDesc ? "desc" : "asc"}&product_list_order=${categoriesUrl[value]}&";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZacatrusOrder &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          isDesc == other.isDesc;

  @override
  int get hashCode => value.hashCode ^ isDesc.hashCode;
}
