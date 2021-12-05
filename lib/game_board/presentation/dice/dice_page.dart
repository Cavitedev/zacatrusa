import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:shake/shake.dart';

import '../../../constants/app_margins_and_sizes.dart';
import '../../../constants/color_x.dart';
import '../../domain/dice/dice.dart';

class DicePage extends StatefulWidget {
  const DicePage({Key? key}) : super(key: key);

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  late Dices dices;
  DicesResult? dicesResult;

  bool canVibrate = false;

  late ShakeDetector detector;

  @override
  void initState() {
    super.initState();
    _checkVibration();

    dices = Dices(dices: [Dice(faces: 6)]);
    _rollDice();

    detector = ShakeDetector.waitForStart(onPhoneShake: _rollDice);

    detector.startListening();

    ShakeDetector.autoStart(onPhoneShake: _rollDice);
  }

  @override
  void dispose() {
    detector.stopListening();
    super.dispose();
  }

  Future<void> _checkVibration() async {
    canVibrate = await Vibrate.canVibrate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const PageScrollPhysics(),
        slivers: [
          const SliverAppBar(
            title: Text("Dado"),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
                generalPadding, generalPadding, generalPadding, 0),
            sliver: SliverToBoxAdapter(
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
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: generalPadding),
            sliver: SliverToBoxAdapter(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Total ${dicesResult?.total ?? 0}",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
          ),
          if (dicesResult != null)
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                  horizontal: generalPadding, vertical: 24),
              sliver: SliverGrid(
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
            ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: _rollDice, child: const Text("🎲")),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _rollDice() async {
    setState(() {
      dicesResult = dices.throwDices();
    });
    if (canVibrate) {
      Vibrate.vibrate();
    }
  }
}

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
                  color: Theme.of(context)
                      .primaryColor
                      .textColorForThisBackground()),
            ),
          )),
    );
  }
}
