import 'package:flutter_test/flutter_test.dart';
import 'package:zacatrusa/game_board/domain/url/category_amount.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/filters/zacatrus_looking_for_filter_options.dart';

void main() {
  group("Looking For Options", () {
    test("Check is not a valid name", () {
      const lookingForFilterOption = ZacatrusLookingForFilterOptions(
          categoriesAmount: [CategoryAmount(name: "Wrong", amount: 1)]);

      expect(lookingForFilterOption.isValid(), false);
    });


    test("Check it is valid", () {
      const lookingForFilterOption = ZacatrusLookingForFilterOptions(
          categoriesAmount: [CategoryAmount(name: "Familiares", amount: 100)]);

      expect(lookingForFilterOption.isValid(), true);
    });
  });
}
