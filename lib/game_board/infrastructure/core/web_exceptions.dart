abstract class InternetFeedback {
  InternetFeedback({
    required this.msg,
  });

  final String msg;

  @override
  String toString() {
    return msg;
  }
}

class InternetLoading extends InternetFeedback{
  InternetLoading({required String msg}) : super(msg: msg);
}

abstract class InternetError extends InternetFeedback {
  InternetError({required String msg}) : super(msg: msg);
}

class NoInternetError extends InternetError {
  NoInternetError({required String msg}) : super(msg: msg);
}

class NoInternetRetryError extends InternetError {
  NoInternetRetryError({required String msg}) : super(msg: msg);
}
