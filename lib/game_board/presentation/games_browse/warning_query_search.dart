import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/settings/settings_controller.dart';

class DowngradeQuerySearchWarningDialog extends ConsumerWidget {
  const DowngradeQuerySearchWarningDialog({
    required this.onAccept,
    Key? key,
  }) : super(key: key);

  final Function onAccept;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool shouldNotify =
        ref.watch(settingsControllerProvider).notifyQueryDowngradeWarning;

    return AlertDialog(
      title: const Text("Búsqueda no puede ser completa"),
      scrollable: true,
      content: Column(
        children: [
          const SelectableText(
            """
Los siguientes filtros no son compatibles con la búsqueda por nombre:
• Categoría
• Edades
• Precio
• Editorial
Tenga en cuenta que dichos filtros solo se aplicarán cuando no se busque por nombre.
          """,
          ),
          CheckboxListTile(
            value: shouldNotify,
            title: const Text("No mostrar de nuevo"),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {
              ref
                  .read(settingsControllerProvider)
                  .updateNotifyQueryDowngradeWarning(value);
            },
          ),
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancelar")),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onAccept.call();
            },
            child: const Text("Aceptar"))
      ],
    );
  }
}
