import 'package:flutter/material.dart';

import '../../../../constants/app_margins_and_sizes.dart';

class NumberArrowsField extends StatefulWidget {
  const NumberArrowsField({
    required this.minAmount,
    required this.maxAmount,
    required this.currentAmount,
    required this.onAmountChange,
    Key? key,
  }) : super(key: key);

  final int minAmount;
  final int maxAmount;
  final int currentAmount;
  final Function(bool increasing) onAmountChange;

  @override
  State<NumberArrowsField> createState() => _NumberArrowsFieldState();
}

class _NumberArrowsFieldState extends State<NumberArrowsField> {
  late int _currentAmount;

  @override
  void initState() {
    super.initState();
    _currentAmount = widget.currentAmount;
  }

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
          onPressed: () {
            if (_currentAmount == widget.minAmount) {
              return;
            }
            setState(() {
              _currentAmount--;
            });
            widget.onAmountChange(false);
          },
          icon: const Icon(Icons.chevron_left),
          splashRadius: 16,
          padding: const EdgeInsets.all(4),
          tooltip: "Restar un dado",
        ),
        Text(
          widget.currentAmount.toString(),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        IconButton(
          onPressed: () {
            if (_currentAmount == widget.maxAmount) {
              return;
            }
            setState(() {
              _currentAmount++;
            });
            widget.onAmountChange(true);
          },
          icon: const Icon(Icons.chevron_right),
          splashRadius: 16,
          padding: const EdgeInsets.all(4),
          tooltip: "Añadir un dado",
        ),
      ],
    );
  }
}
