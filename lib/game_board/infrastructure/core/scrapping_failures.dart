import 'internet_feedback.dart';

abstract class ScrappingFailure extends InternetFeedback {
  ScrappingFailure({required String url}) : super(url: url);
}

class ParsingFailure extends ScrappingFailure {
  ParsingFailure({required String url}) : super(url: url);
}

class NoGamesFailure extends ScrappingFailure {
  NoGamesFailure({required String url}) : super(url: url);
}

class NoMoreGamesFailure extends ScrappingFailure {
  NoMoreGamesFailure({required String url}) : super(url: url);
}

class QueryLengthNotEnough extends InternetFeedback {
  QueryLengthNotEnough({required String url}) : super(url: url);
}
