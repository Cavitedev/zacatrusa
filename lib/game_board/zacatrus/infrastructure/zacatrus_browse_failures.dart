import 'package:zacatrusa/game_board/infrastructure/core/internet_feedback.dart';

class NoGamesFoundFailure extends InternetFeedback {
  NoGamesFoundFailure({required String url}) : super(url: url);
}
