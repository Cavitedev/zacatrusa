import 'package:app_settings/app_settings.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceToSpeechButton extends StatefulWidget {
  const VoiceToSpeechButton({
    required this.onWordHeard,
    Key? key,
  }) : super(key: key);

  final Function(String) onWordHeard;

  @override
  State<StatefulWidget> createState() => _VoiceToSpeechButtonState();
}

class _VoiceToSpeechButtonState extends State<VoiceToSpeechButton> {
  String? currentStatus;
  late stt.SpeechToText speech;

  @override
  void initState() {
    super.initState();
    speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      animate: speech.isListening,
      endRadius: 24,
      glowColor: Theme.of(context).primaryColor,
      duration: const Duration(milliseconds: 1000),
      repeatPauseDuration: const Duration(milliseconds: 100),
      repeat: true,
      curve: Curves.fastOutSlowIn,
      child: IconButton(
          onPressed: () async {
            if (!speech.isAvailable) {
              await Permission.speech.request();
              final pemissionStatus = await Permission.speech.status;
              if (pemissionStatus.isDenied) {
                showFlash(
                    context: context,
                    builder: (context, controller) {
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
                                "Se necesita permisos de microfono para poder utilizar el reconocimiento por voz. Pulse el icono del engranaje para ir a los ajustes de la aplicación y cambie los permisos"),
                            primaryAction: IconButton(
                              onPressed: () async {
                                await AppSettings.openAppSettings();
                              },
                              icon: const Icon(Icons.settings_applications),
                              iconSize: 36,
                              color: Colors.black,
                            ),
                            icon: Icon(
                              Icons.warning,
                              color: Colors.amberAccent.shade700,
                            ),
                          ));
                    });
                // _showB;
                return;
              }
              await speech.initialize();
            }
            speech.statusListener = _onStatus;
            if (speech.isListening) {
              await speech.stop();
            } else {
              await speech.listen(
                  onResult: (SpeechRecognitionResult str) {
                    widget.onWordHeard(str.recognizedWords);
                  },
                  localeId: "es_ES");
            }
          },
          icon: Icon(
            speech.isListening ? Icons.mic_rounded : Icons.mic_none_rounded,
          )),
    );
  }

  void _onStatus(nextStatus) {
    setState(() {
      currentStatus = nextStatus;
    });
  }
}
