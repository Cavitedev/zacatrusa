import 'package:flutter/cupertino.dart';

@immutable
class QueryParameter<T> {
  const QueryParameter({
    required this.key,
    required this.value,
  });

  final String key;
  final T value;

  String toParam() => key + "=" + value.toString() + "&";

  QueryParameter copyWith({
    T? value,
  }) {
    return QueryParameter(
      key: key,
      value: value ?? this.value,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QueryParameter &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          value == other.value;

  @override
  int get hashCode => key.hashCode ^ value.hashCode;
}
