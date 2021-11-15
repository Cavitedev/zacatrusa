import '../../../../domain/url/query_parameter.dart';

class ZacatrusQueryFilter extends QueryParameter<String> {
  const ZacatrusQueryFilter({
    required String value,
  }) : super(key: "q", value: value);
}
