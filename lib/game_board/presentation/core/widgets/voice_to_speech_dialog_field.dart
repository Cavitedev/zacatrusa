import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../constants/app_margins_and_sizes.dart';
import 'outlined_text_field.dart';
import 'voice_to_speech_button.dart';

class VoiceToSpeechDialogField extends StatelessWidget {
  const VoiceToSpeechDialogField({
    required this.textController,
    Key? key,
  }) : super(key: key);

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: generalPadding),
      child: OutlinedTextField(
        autocorrect: false,
        controller: textController,
        suffixIconWhenNoText: (Platform.isAndroid || Platform.isIOS)
            ? VoiceToSpeechButton(
                onWordHeard: (textHeard, _) {
                  textController.value = TextEditingValue(
                    text: textHeard,
                    selection:
                        TextSelection.collapsed(offset: textHeard.length),
                  );
                },
              )
            : null,
      ),
    );
  }
}
