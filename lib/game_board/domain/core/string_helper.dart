final _numRegex = RegExp(r'[0-9.]+');
final _commaNumRegex = RegExp(r'[0-9,]+');

extension StringX on String {
  String toNumericString() {
    return splitMapJoin(
      _numRegex,
      onMatch: (match) => match.group(0)!,
      onNonMatch: (match) => '',
    );
  }

  num toNum() {
    return num.parse(toNumericString());
  }

  double fromCommaDecimalToNum() {
    String text = splitMapJoin(
      _commaNumRegex,
      onMatch: (match) => match.group(0)!,
      onNonMatch: (match) => '',
    );
    text = text.replaceAll(",", ".");

    return double.parse(text);
  }
}
