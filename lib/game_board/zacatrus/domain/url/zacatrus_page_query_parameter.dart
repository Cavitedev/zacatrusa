import 'package:zacatrusa/game_board/domain/core/query_parameter.dart';

class ZacatrusPageIndex extends QueryParameter<int> {
  ZacatrusPageIndex(int value) : super(key: "p", value: value);

  void nextPage() => value += 1;

  @override
  String toParam() {
    if (value == 1) {
      return "";
    }
    return super.toParam();
  }
}

class ZacatrusPageProductPerPage extends QueryParameter<int> {
  ZacatrusPageProductPerPage(int value)
      : assert(possibleValues.contains(value)),
        super(key: "product_list_limit", value: value);

  static const List<int> possibleValues = [12, 24, 36];

    @override
  String toParam() {
    if (value == 24) {
      return "";
    }
    return super.toParam();
  }

}
