abstract class InternetFeedback {
  InternetFeedback({
    required this.url,
  });

  final String url;


}

class InternetLoading extends InternetFeedback{
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
