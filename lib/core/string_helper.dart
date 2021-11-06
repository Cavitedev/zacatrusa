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

  static const diacritics =
      'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
  static const nonDiacritics =
      'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

  String withoutDiacriticalMarks() =>
      splitMapJoin('',
          onNonMatch: (char) =>
          char.isNotEmpty && diacritics.contains(char)
              ? nonDiacritics[diacritics.indexOf(char)]
              : char);

  String removeDomain() {
    final Uri uri = Uri.parse(this);
    final String path = uri.path.substring(1);
    final String query = uri.query.isEmpty ? "" : "?" + uri.query;
    return path + query;
  }
}
