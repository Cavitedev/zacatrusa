import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

final speechProvider = Provider((_) => stt.SpeechToText());

class VoiceToSpeechButton extends ConsumerStatefulWidget {
  const VoiceToSpeechButton({
    required this.onWordHeard,
    Key? key,
  }) : super(key: key);

  final Function(String) onWordHeard;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VoiceToSpeechButtonState();
}

class _VoiceToSpeechButtonState extends ConsumerState<VoiceToSpeechButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final speech = ref.watch(speechProvider);

    return IconButton(
        onPressed: () async {
          if (!speech.isAvailable) {
            await Permission.speech.request();
            await speech.initialize(onStatus: (_) {
              setState(() {});
            });
          }
          await speech.listen(
              onResult: (SpeechRecognitionResult str) {
                widget.onWordHeard(str.recognizedWords);
              },
              localeId: "es_ES");
          setState(() {});
        },
        icon: Icon(
          speech.isListening ? Icons.mic_rounded : Icons.mic_off_rounded,
        ));
  }
}
