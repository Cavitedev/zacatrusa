class CategoryAmount {
  const CategoryAmount({
    required this.name,
    required this.amount,
  }) : assert(amount > 0);

  final String name;
  final int amount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryAmount &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          amount == other.amount;

  @override
  int get hashCode => name.hashCode ^ amount.hashCode;
}
