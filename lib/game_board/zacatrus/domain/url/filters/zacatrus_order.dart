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
}
