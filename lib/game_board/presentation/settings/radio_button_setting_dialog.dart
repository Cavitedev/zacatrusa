import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/constants/app_margins_and_sizes.dart';

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
  late final List<MapEntry> _msgValuesList;
  late final ScrollController _scrollController;
  late int _indexSelectedElement;
  static const double elementSize = 56;
  static const int thresholdToScrollAutomatically = 10;

  @override
  void initState() {
    super.initState();
    _msgValuesList = widget.messageValues.entries.toList();
    _scrollController = ScrollController();
    if (_msgValuesList.length > thresholdToScrollAutomatically) {
      final selectedValue = ref.read(widget.provider);
      _indexSelectedElement =
          _msgValuesList.indexWhere((entry) => entry.key == selectedValue);
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        _scrollController.jumpTo(_indexSelectedElement * elementSize);
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final T groupValue = ref.watch(widget.provider);
    final List<MapEntry> msgValuesList = widget.messageValues.entries.toList();

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
              onPressed: () {
                _scrollController.jumpTo(100);
              },
              child: Text("butón")),
          Expanded(
            child: Scrollbar(
              controller: _scrollController,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: msgValuesList.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  MapEntry msgVal = msgValuesList[index];
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
