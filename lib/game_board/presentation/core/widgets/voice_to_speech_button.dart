import 'package:avatar_glow/avatar_glow.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'flash_widgets.dart';

/// Voice recognitoin widget that only works on Android, and maybe iOS with some configuration changes
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
                      return MicrophonePermissionFlash(
                        controller: controller,
                      );
                    });
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
