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

class DialogRadioColumn<T> extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final T groupValue = ref.watch(provider);
    final List<MapEntry> msgValuesList = messageValues.entries.toList();

    return Expanded(
      child: ListView.builder(
        itemCount: msgValuesList.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          MapEntry msgVal = msgValuesList[index];
          return _buildRadioListTile(
              context: context,
              value: msgVal.key,
              msg: msgVal.value,
              groupValue: groupValue,
              ref: ref);
        },
      ),
    );
  }

  RadioListTile<T> _buildRadioListTile({
    required BuildContext context,
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
        onChanged(newValue);
        Navigator.pop(context);
      },
    );
  }
}
