import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../constants/app_margins_and_sizes.dart';

class NumberArrowsField extends StatelessWidget {
  const NumberArrowsField({
    required this.currentAmount,
    required this.onAmountChange,
    Key? key,
  }) : super(key: key);

  final int currentAmount;
  final Function(bool increasing) onAmountChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Cantidad de dados",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        const SizedBox(
          width: separatorPadding,
        ),
        IconButton(
          onPressed: _decreaseDicesNumber,
          icon: const Icon(Icons.remove),
          splashRadius: 16,
          padding: const EdgeInsets.all(4),
          tooltip: "Restar un dado" +
              ((Platform.isWindows || Platform.isMacOS || Platform.isLinux)
                  ? " (-)"
                  : ""),
        ),
        Text(
          currentAmount.toString(),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        IconButton(
          onPressed: _increasesDicesNumber,
          icon: const Icon(Icons.add),
          splashRadius: 16,
          padding: const EdgeInsets.all(4),
          tooltip: "Añadir un dado" +
              ((Platform.isWindows || Platform.isMacOS || Platform.isLinux)
                  ? " (+)"
                  : ""),
        ),
      ],
    );
  }

  void _increasesDicesNumber() {
    onAmountChange(true);
  }

  void _decreaseDicesNumber() {
    onAmountChange(false);
  }
}
