import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/game_board/presentation/settings/radio_button_setting_dialog.dart';
import 'package:zacatrusa/settings/settings_controller.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajustes"),
      ),
      body: ListView(
        children: [
          RadioButtonSettingDialog(
              name: "Tipo de letra",
              dialogTitle: "Elija tipo de letra",
              provider: settingsFontFamilyControllerProvider,
              messageValues: [
                MessageValue(message: "Roboto", value: "roboto"),
                MessageValue(message: "OpenSans", value: "open_sans")
              ],
              onChanged: (value) {
                ref
                    .read(settingsControllerProvider)
                    .updateFontfamily(value.toString());
              }),
        ],
      ),
    );
  }
}
