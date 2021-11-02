import 'package:flutter_test/flutter_test.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/zacatrus_si_buscas_filter.dart';

void main() {
  group("Looking For Options", () {
    test("Check is not a valid name", () {
      const lookingForFilterOption = ZacatrusSiBuscasFilter(value: "Wrong");

      expect(lookingForFilterOption.isValid(), false);
    });

    test("Check it is valid", () {
      const lookingForFilterOption =
          ZacatrusSiBuscasFilter(value: "Familiares");

      expect(lookingForFilterOption.isValid(), true);
    });
  });
}
