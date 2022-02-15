import 'package:flutter/material.dart';

class DiceButtonWithLayout extends StatelessWidget {
  const DiceButtonWithLayout({
    required this.rollDice,
    Key? key,
  }) : super(key: key);

  final void Function() rollDice;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: IntrinsicHeight(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: rollDice,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: const Text("🎲 Tirar Dados"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
