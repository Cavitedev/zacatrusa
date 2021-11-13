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
    return IconButton(
        onPressed: () async {
          if (!speech.isAvailable) {
            await Permission.speech.request();
            await speech.initialize(onStatus: (nextStatus) {
              setState(() {
                currentStatus = nextStatus;
              });
            });
          }

          await speech.listen(
              onResult: (SpeechRecognitionResult str) {
                widget.onWordHeard(str.recognizedWords);
              },
              localeId: "es_ES");
        },
        icon: Icon(
          speech.isListening ? Icons.mic_rounded : Icons.mic_off_rounded,
        ));
  }
}
