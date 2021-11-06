import 'package:flutter/material.dart';

import '../../../infrastructure/core/internet_feedback.dart';
import '../../../infrastructure/core/scrapping_failures.dart';
import 'error_widget_with_image.dart';
import 'loading.dart';

class InternetFeedbackWidget extends StatelessWidget {
  const InternetFeedbackWidget({
    required this.feedback,
    Key? key,
  }) : super(key: key);

  final InternetFeedback feedback;

  @override
  Widget build(BuildContext context) {
    String url = feedback.url;
    String txt = "No debe aparacer, reportálo en github zacatrusa";
    if (feedback is InternetFailure) {
      if (feedback is NoInternetFailure) {
        return ErrorWidgetWithImage(
          msg:
              "No hay internet para conectarse a $url. compruebe su conexión y reinténtalo haciendo scroll hacía arriba",
          image: "assets/images/undraw_connected_world_wuay.svg",
        );
      } else if (feedback is NoInternetRetryFailure) {
        return ErrorWidgetWithImage(
          msg:
              "No estás conectado a ninguna red. Activa la wifi, cable ethernet o datos móviles. La conexión con $url se repetirá automáticamente",
          image: "assets/images/undraw_signal_searching_bhpc.svg",
        );
      } else if (feedback is StatusCodeInternetFailure) {
        final statusfeedback = feedback as StatusCodeInternetFailure;
        txt = """
Error código ${statusfeedback.statusCode} en la página ${statusfeedback.url}""";

        return ErrorWidgetWithImage(
          msg:
              "Error código ${statusfeedback.statusCode} en la página ${statusfeedback.url}",
          image: statusfeedback.statusCode == 404
              ? "assets/images/undraw_page_not_found_re_e9o6.svg"
              : "assets/images/undraw_server_down_s-4-lk.svg",
        );
      }
    } else if (feedback is ScrappingFailure) {
      if (feedback is ParsingFailure) {
        return const ErrorWidgetWithImage(
          msg: "No aparecen juegos en la búsqueda, error de parseo",
          image: "assets/images/undraw_the_search_s0xf.svg",
        );
      } else if (feedback is NoGamesFailure) {
        return const ErrorWidgetWithImage(
          msg: "No se ha encontrado ningún juego",
          image: "assets/images/undraw_blank_canvas_-3-rbb.svg",
        );
      } else if (feedback is NoMoreGamesFailure) {
        return const ErrorWidgetWithImage(
          msg: "No se han encontrado más juegos, pruebe con otros filtros",
          image: "assets/images/undraw_empty_cart_co35.svg",
        );
      }
    } else if (feedback is InternetLoading) {
      txt = "Cargando $url";
      return Loading(msg: txt);
    } else if (feedback is InternetReloading) {
      txt = "Reintentando cargar $url";
      return Loading(msg: txt);
    }

    return const Text("No debe aparacer, reportálo en github zacatrusa");
  }
}
