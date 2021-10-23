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

abstract class InternetFailure extends InternetFeedback {
  InternetFailure({required String msg}) : super(msg: msg);
}

class NoInternetFailure extends InternetFailure {
  NoInternetFailure({required String msg}) : super(msg: msg);
}

class NoInternetRetryFailure extends InternetFailure {
  NoInternetRetryFailure({required String msg}) : super(msg: msg);
}
