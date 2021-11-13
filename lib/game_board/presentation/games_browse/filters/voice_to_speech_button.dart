import 'package:avatar_glow/avatar_glow.dart';
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
      endRadius: 50,
      glowColor: Theme.of(context).primaryColor,
      duration: const Duration(milliseconds: 1000),
      repeatPauseDuration: const Duration(milliseconds: 100),
      repeat: true,
      curve: Curves.fastOutSlowIn,
      child: FloatingActionButton(
          onPressed: () async {
            if (!speech.isAvailable) {
              await Permission.speech.request();
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
          child: Icon(
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
