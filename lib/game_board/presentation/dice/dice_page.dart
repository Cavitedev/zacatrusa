import 'package:flutter/material.dart';

import '../../../constants/app_margins_and_sizes.dart';
import '../../../constants/color_x.dart';
import '../../domain/dice/dice.dart';

class DicePage extends StatefulWidget {
  const DicePage({Key? key}) : super(key: key);

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  Dices dices = Dices(dices: []);
  DicesResult? dicesResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dado"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Amount of dices",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(
                  width: separatorPadding,
                ),
                SizedBox(
                  width: 50,
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    autocorrect: false,
                    maxLength: 1,
                    decoration: const InputDecoration(counterText: ""),
                    onChanged: (text) {
                      int amount = int.parse(text);
                      dices.dices =
                          List.generate(amount, (index) => Dice(faces: 6));
                    },
                  ),
                )
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Total ${dicesResult?.total ?? 0}",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          if (dicesResult != null)
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                return DiceResultWidget(
                  diceResult: dicesResult!.dicesResult[index],
                );
              }, childCount: dicesResult!.dicesResult.length),
            ),
          SliverToBoxAdapter(
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    dicesResult = dices.throwDices();
                  });
                },
                child: const Text("🎲")),
          )
        ],
      ),
    );
  }
}

class DiceResultWidget extends StatelessWidget {
  DiceResultWidget({
    required this.diceResult,
    Key? key,
  }) : super(key: key);

  DiceResult diceResult;

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
              style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Theme.of(context)
                      .primaryColor
                      .textColorForThisBackground()),
            ),
          )),
    );
  }
}
