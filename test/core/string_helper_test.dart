import 'package:flutter_test/flutter_test.dart';
import 'package:zacatrusa/core/string_helper.dart';

void main() {
  group("fromCommaDecimalToNum", () {
    test("9,95 € works fine", () {
      const str = "9,95 €";

      final double result = str.fromCommaDecimalToNum();

      expect(result, 9.95);
    });
  });

  group("To Url Valid Characters", () {
    test("Parses spaces works", () {
      const str = "Para 2";

      final String result = str.toUrlValidCharacters();

      expect(result, "para_2");
    });

    test("Parses accents works", () {
      const str = "Rápido";

      final String result = str.toUrlValidCharacters();

      expect(result, "rapido");
    });
  });
}
