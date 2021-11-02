import 'package:flutter_test/flutter_test.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_edades_filter.dart';

void main() {
  group("Is valid", () {
    test("Repeated element is not valid", () {
      ZacatrusEdadesFilter edad = const ZacatrusEdadesFilter(
          values: ["de 0 a 3 años", "de 0 a 3 años"]);

      expect(edad.isValid(), false);
    });
  });
}
