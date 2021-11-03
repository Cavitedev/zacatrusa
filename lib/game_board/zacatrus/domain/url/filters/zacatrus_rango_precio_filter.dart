import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/i_filter.dart';

class ZacatrusRangoPrecioFilter implements IFilter {
  final double min;
  final double max;

  const ZacatrusRangoPrecioFilter({
    required this.min,
    required this.max,
  }) : assert(min <= max && min >= 10 && max <= 270);

  @override
  String? toUrl() {
    return "price=" + min.toStringAsFixed(2) + "-" + max.toStringAsFixed(2);
  }

  @override
  bool isValid() {
    // Managed on assert
    throw UnimplementedError();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZacatrusRangoPrecioFilter &&
          runtimeType == other.runtimeType &&
          min == other.min &&
          max == other.max;

  @override
  int get hashCode => min.hashCode ^ max.hashCode;
}
