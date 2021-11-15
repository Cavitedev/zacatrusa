import 'package:flutter/material.dart';
import 'package:zacatrusa/constants/app_margins_and_sizes.dart';

class SettingsDialog extends StatelessWidget {
  final Widget content;
  final String title;

  const SettingsDialog({
    Key? key,
    required this.content,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 16,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  generalPadding, generalPadding, generalPadding, 0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ),
            content,
            Padding(
              padding: const EdgeInsets.all(generalPadding),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Cancelar",
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Theme.of(context).primaryColor,
                  )),
            )
          ],
        ));
  }
}
