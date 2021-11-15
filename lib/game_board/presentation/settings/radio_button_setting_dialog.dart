import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/constants/app_margins_and_sizes.dart';
import 'package:zacatrusa/game_board/presentation/core/widgets/voice_to_speech_dialog_field.dart';

import 'settings_dialog.dart';

class RadioButtonSettingDialog<T> extends ConsumerWidget {
  const RadioButtonSettingDialog({
    required this.name,
    required this.dialogTitle,
    required this.provider,
    required this.messageValues,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final String name;
  final Map<T, String> messageValues;
  final Provider<T> provider;
  final String dialogTitle;
  final Function(T?) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final T value = ref.watch(provider);
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 48, right: generalPadding),
      title: Text(name),
      subtitle: Text(messageValues[value] ?? "no se ha encontrado"),
      onTap: () {
        showDialog(
          context: context,
          builder: (_) {
            return ChangeValueDialog<T>(
              messageValues: messageValues,
              title: dialogTitle,
              provider: provider,
              onChanged: onChanged,
            );
          },
        );
      },
    );
  }
}

class ChangeValueDialog<T> extends StatelessWidget {
  final Map<T, String> messageValues;
  final Provider<T> provider;
  final String title;
  final Function(T?) onChanged;

  const ChangeValueDialog({
    required this.messageValues,
    required this.provider,
    required this.title,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsDialog(
      title: title,
      content: DialogRadioColumn(
        messageValues: messageValues,
        provider: provider,
        onChanged: onChanged,
      ),
    );
  }
}

class DialogRadioColumn<T> extends ConsumerStatefulWidget {
  final Map<T, String> messageValues;
  final Provider<T> provider;
  final Function(T?) onChanged;

  const DialogRadioColumn({
    required this.messageValues,
    required this.provider,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DialogRadioColumnState<T>();
}

class _DialogRadioColumnState<T> extends ConsumerState<DialogRadioColumn<T>> {
  late List<MapEntry> _msgValuesList;
  late int _indexSelectedElement;
  late final int _msgValuesInitialLength;

  ScrollController? _scrollController;
  TextEditingController? _textController;

  static const double elementSize = 56;
  static const int thresholdToScrollAutomatically = 10;

  @override
  void initState() {
    super.initState();
    _msgValuesList = widget.messageValues.entries.toList();
    _msgValuesInitialLength = _msgValuesList.length;
    if (_msgValuesInitialLength > thresholdToScrollAutomatically) {
      _textController = TextEditingController();

      _textController!.addListener(() {
        setState(() {
          _msgValuesList = widget.messageValues.entries
              .where((entry) => entry.value
                  .toLowerCase()
                  .contains(_textController!.text.toLowerCase()))
              .toList();
        });
      });

      _scrollController = ScrollController();

      final selectedValue = ref.read(widget.provider);
      _indexSelectedElement =
          _msgValuesList.indexWhere((entry) => entry.key == selectedValue);
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        _scrollController!.jumpTo(_indexSelectedElement * elementSize);
      });
    }
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    _textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final T groupValue = ref.watch(widget.provider);

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_msgValuesInitialLength > thresholdToScrollAutomatically)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: VoiceToSpeechDialogField(textController: _textController!),
            ),
          Expanded(
            child: Scrollbar(
              controller: _scrollController,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _msgValuesList.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  MapEntry msgVal = _msgValuesList[index];
                  return _buildRadioListTile(
                      context: context,
                      index: index,
                      value: msgVal.key,
                      msg: msgVal.value,
                      groupValue: groupValue,
                      ref: ref);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  RadioListTile<T> _buildRadioListTile({
    required BuildContext context,
    required int index,
    required T value,
    required T groupValue,
    required String msg,
    required WidgetRef ref,
  }) {
    return RadioListTile<T>(
      groupValue: groupValue,
      value: value,
      title: Text(msg),
      onChanged: (newValue) {
        widget.onChanged(newValue);
        Navigator.pop(context);
      },
    );
  }
}
