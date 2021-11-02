class ZacatrusRangoPrecioFilter {
  final double min;
  final double max;

  const ZacatrusRangoPrecioFilter({
    required this.min,
    required this.max,
  }) : assert(min <= max && min >= 10 && max <= 270);

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
