import 'package:flutter/material.dart';

import '../../../../constants/color_x.dart';
import '../../../domain/dice/dice.dart';

class DiceResultWidget extends StatelessWidget {
  const DiceResultWidget({
    required this.diceResult,
    Key? key,
  }) : super(key: key);

  final DiceResult diceResult;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: Container(
          padding: const EdgeInsets.all(8),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: Offset(2, 2))
              ]),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              diceResult.result.toString(),
              style: Theme.of(context).textTheme.headline3!.copyWith(
                  height: 1,
                  color: Theme.of(context)
                      .primaryColor
                      .textColorForThisBackground()),
            ),
          )),
    );
  }
}
