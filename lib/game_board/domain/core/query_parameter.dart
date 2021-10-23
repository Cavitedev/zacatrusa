class QueryParameter<T> {
  QueryParameter({
    required this.key,
    required this.value,
  });

  final String key;
   T value;

  String toParam() => key + "=" + value.toString() + "&";


}
