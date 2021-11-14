import 'package:app_settings/app_settings.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

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
