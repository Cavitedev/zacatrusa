import 'package:flutter_test/flutter_test.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/zacatrus_path_modifier_arguments.dart';

void main() {
  group("Looking For Options", () {
    test("Check is not a valid name", () {
      const lookingForFilterOption = ZacatrusLookingForFilter(category: "Wrong");

      expect(lookingForFilterOption.isValid(), false);
    });


    test("Check it is valid", () {
      const lookingForFilterOption = ZacatrusLookingForFilter(category: "Familiarse");

      expect(lookingForFilterOption.isValid(), true);
    });
  });
}
