abstract class IFilter {
  String? toUrl();

  bool isValid();
}

abstract class ISingleFilter extends IFilter {
  String get value;
}

abstract class IMultipleFilter extends IFilter {
  List<String> get values;
}
