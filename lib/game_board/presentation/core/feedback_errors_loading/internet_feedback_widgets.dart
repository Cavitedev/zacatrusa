import 'package:flutter/material.dart';
import 'package:zacatrusa/game_board/infrastructure/core/internet_feedback.dart';
import 'package:zacatrusa/game_board/presentation/core/feedback_errors_loading/loading.dart';

class InternetFeedbackWidget extends StatelessWidget {
  const InternetFeedbackWidget({
    required this.feedback,
    Key? key,
  }) : super(key: key);

  final InternetFeedback feedback;

  @override
  Widget build(BuildContext context) {
    String url = feedback.url;
    String txt = "Should never be displayed";
    if (feedback is InternetFailure) {
      if (feedback is NoInternetFailure) {
        txt = """
No hay internet para conectarse a $url.
compruebe su conexión""";
      } else if (feedback is NoInternetRetryFailure) {
        txt = """
No estás conectado a ninguna red.
Activa la wifi, cable ethernet o datos móviles.
La conexión con $url se repetirá automáticamente""";
      } else if (feedback is StatusCodeInternetFailure) {
        final statusfeedback = feedback as StatusCodeInternetFailure;
        txt = """
Error código ${statusfeedback.statusCode} en la página ${statusfeedback.url}""";
      }

      return Text(txt);
    } else if (feedback is InternetLoading) {
      txt = "Retrying to load $url";
      return Loading(msg: txt);
    }

    return const Text("Should never be reached");
  }
}