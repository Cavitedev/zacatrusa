import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/app_margins_and_sizes.dart';
import '../../../settings/material_color_data.dart';
import 'settings_dialog.dart';

class ColorRadioButtonSettingDialog<T> extends ConsumerWidget {
  const ColorRadioButtonSettingDialog({
    required this.name,
    required this.dialogTitle,
    required this.provider,
    required this.messageValues,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final String name;
  final Map<T, MaterialColorData> messageValues;
  final Provider<T> provider;
  final String dialogTitle;
  final Function(T?) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final T value = ref.watch(provider);
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 48, right: generalPadding),
      trailing: CircleColorContianer(
        color: messageValues[value]?.color,
      ),
      title: Text(name),
      subtitle: Text(messageValues[value]?.msg ?? "no se ha encontrado"),
      onTap: () {
        showDialog(
          context: context,
          builder: (_) {
            return ChangeColorValueDialog<T>(
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

class ChangeColorValueDialog<T> extends StatelessWidget {
  final Map<T, MaterialColorData> messageValues;
  final Provider<T> provider;
  final String title;
  final Function(T?) onChanged;

  const ChangeColorValueDialog({
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
      content: ColorDialogRadioColumn(
        messageValues: messageValues,
        provider: provider,
        onChanged: onChanged,
      ),
    );
  }
}

class ColorDialogRadioColumn<T> extends ConsumerWidget {
  final Map<T, MaterialColorData> messageValues;
  final Provider<T> provider;
  final Function(T?) onChanged;

  const ColorDialogRadioColumn({
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
            final msgVal = msgValuesList[index];
            return _buildRadioListTile(
                context: context,
                value: msgVal.key,
                msg: msgVal.value.msg,
                color: msgVal.value.color,
                groupValue: groupValue,
                ref: ref);
          }),
    );
  }

  RadioListTile<T> _buildRadioListTile({
    required BuildContext context,
    required T value,
    required T groupValue,
    required String msg,
    required Color color,
    required WidgetRef ref,
  }) {
    return RadioListTile<T>(
      groupValue: groupValue,
      value: value,
      title: Row(
        children: [
          CircleColorContianer(
            color: color,
          ),
          const SizedBox(
            width: 12,
          ),
          Text(msg),
        ],
      ),
      onChanged: (newValue) {
        onChanged(newValue);
        Navigator.pop(context);
      },
    );
  }
}

class CircleColorContianer extends StatelessWidget {
  const CircleColorContianer({
    this.color,
    Key? key,
  }) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
