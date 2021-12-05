import 'package:flutter/material.dart';
import 'package:zacatrusa/constants/app_margins_and_sizes.dart';
import 'package:zacatrusa/game_board/domain/dice/dice.dart';

class DicePage extends StatefulWidget {
  const DicePage({Key? key}) : super(key: key);

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  Dices dices = Dices(dices: []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dado"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(generalPadding),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Amount of dices"),
                SizedBox(
                  width: separatorPadding,
                ),
                SizedBox(
                  width: 50,
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    autocorrect: false,
                    maxLength: 1,
                    decoration: InputDecoration(counterText: ""),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Total 12",
              ),
            ),
            Spacer(),
            Text("3"),
            Spacer(),
            ElevatedButton(onPressed: () {}, child: Text("🎲"))
          ],
        ),
      ),
    );
  }
}
