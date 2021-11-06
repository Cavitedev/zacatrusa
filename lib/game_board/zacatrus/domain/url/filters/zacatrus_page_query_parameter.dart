import 'package:flutter/cupertino.dart';

import '../../../../domain/url/query_parameter.dart';

@immutable
class ZacatrusPageIndex extends QueryParameter<int> {
  const ZacatrusPageIndex(int value) : super(key: "p", value: value);

  ZacatrusPageIndex copyWithNextPage() {
    return ZacatrusPageIndex(value + 1);
  }

  @override
  String toParam() {
    if (value == 1) {
      return "";
    }
    return super.toParam();
  }


}

@immutable
class ZacatrusProductsPerPage extends QueryParameter<int> {
  const ZacatrusProductsPerPage(int value)
      : assert(value == 12 || value == 24 || value == 36),
        super(key: "product_list_limit", value: value);

  @override
  String toParam() {
    if (value == 24) {
      return "";
    }
    return super.toParam();
  }


}
