import 'package:app_settings/app_settings.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';

class MicrophonePermissionFlash extends StatelessWidget {
  const MicrophonePermissionFlash({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final FlashController controller;

  @override
  Widget build(BuildContext context) {
    return Flash(
        controller: controller,
        behavior: FlashBehavior.floating,
        position: FlashPosition.bottom,
        barrierBlur: 2,
        boxShadows: const [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 10,
              spreadRadius: 5)
        ],
        child: FlashBar(
          title: Text(
            "No hay permisos suficientes",
            style: Theme.of(context).textTheme.headline6,
          ),
          content: const Text(
              "Se necesita permisos de microfono para poder utilizar el reconocimiento por voz. Pulse el icono del engranaje para ir a los ajustes de la aplicación y cambiar los permisos"),
          primaryAction: IconButton(
            onPressed: () async {
              await AppSettings.openAppSettings();
            },
            icon: const Icon(Icons.settings_applications),
            iconSize: 36,
            color: Colors.black,
          ),
          shouldIconPulse: false,
          icon: Icon(
            Icons.warning,
            color: Colors.amberAccent.shade700,
          ),
        ));
  }
}

class SpeechErrorFlash extends StatelessWidget {
  const SpeechErrorFlash({
    required this.controller,
    required this.error,
    Key? key,
  }) : super(key: key);

  final FlashController controller;
  final SpeechRecognitionError error;

  @override
  Widget build(BuildContext context) {
    return Flash(
        controller: controller,
        behavior: FlashBehavior.floating,
        position: FlashPosition.bottom,
        boxShadows: const [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 10,
              spreadRadius: 5)
        ],
        child: FlashBar(
          title: Text(
            "Error en reconocimiento de voz",
            style: Theme.of(context).textTheme.headline6,
          ),
          content: Text(_convertErrorMsg()),
          shouldIconPulse: false,
          icon: _isErrorImportant()
              ? Icon(
                  Icons.error,
                  color: Theme.of(context).errorColor,
                )
              : const Icon(
                  Icons.info,
                ),
        ));
  }

  String _convertErrorMsg() {
    if (_isTimeOut()) {
      return "No se ha escuchado ninguna palabra durante el tiempo de activación, compruebe que funciona su microfono";
    } else if (_isNoMatch()) {
      "No hemos encontrado ninguna palabra en lo que has dicho. Inténtalo de nuevo hablando claro y comprobando que el micro funciona";
    }
    return "Ha habido un error con este mensaje: \"${error.errorMsg}\" informe de ello al equipo de desarrollo";
  }

  bool _isErrorImportant() {
    if (_isTimeOut() || _isNoMatch()) {
      return false;
    }
    return true;
  }

  bool _isTimeOut() => error.errorMsg == "error_speech_timeout";
  bool _isNoMatch() => error.errorMsg == "error_no_natch";
}

class SpeechInitializeFlash extends StatelessWidget {
  const SpeechInitializeFlash({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final FlashController controller;

  @override
  Widget build(BuildContext context) {
    return Flash(
        controller: controller,
        behavior: FlashBehavior.floating,
        position: FlashPosition.bottom,
        barrierBlur: 2,
        boxShadows: const [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 10,
              spreadRadius: 5)
        ],
        child: FlashBar(
          title: Text(
            "Error al inicializar el reconocimiento de voz",
            style: Theme.of(context).textTheme.headline6,
          ),
          content: const Text(
              "Hubo un problema al iniciar el reconocimiento de voz, notifíqueselo al equipo de desarrollo por favor"),
          shouldIconPulse: false,
          icon: Icon(
            Icons.error,
            color: Theme.of(context).errorColor,
          ),
        ));
  }
}
