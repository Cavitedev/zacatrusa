abstract class InternetFeedback {
  InternetFeedback({
    required this.url,
  });

  final String url;

  @override
  String toString() {
    return '${runtimeType} {url: $url}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InternetFeedback &&
          runtimeType == other.runtimeType &&
          url == other.url;

  @override
  int get hashCode => url.hashCode;
}

class InternetLoading extends InternetFeedback {
  InternetLoading({required String url}) : super(url: url);

}

abstract class InternetFailure extends InternetFeedback {
  InternetFailure({required String url}) : super(url: url);
}

class NoInternetFailure extends InternetFailure {
  NoInternetFailure({required String url}) : super(url: url);
}

class NoInternetRetryFailure extends InternetFailure {
  NoInternetRetryFailure({required String url}) : super(url: url);
}

class StatusCodeInternetFailure extends InternetFailure {
  StatusCodeInternetFailure({
    required String url,
    required this.statusCode,
  }) : super(url: url);

  final int statusCode;

  @override
  String toString() {
    return 'StatusCodeInternetFailure{statusCode: $statusCode}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is StatusCodeInternetFailure &&
          runtimeType == other.runtimeType &&
          statusCode == other.statusCode;

  @override
  int get hashCode => super.hashCode ^ statusCode.hashCode;
}
