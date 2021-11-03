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
}
