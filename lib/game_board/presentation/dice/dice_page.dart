import 'dart:io';

import 'package:flutter/material.dart';
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

    if (Platform.isAndroid || Platform.isIOS) {
      detector = ShakeDetector.waitForStart(onPhoneShake: _rollDice);
      detector.startListening();
    }

    ShakeDetector.autoStart(onPhoneShake: _rollDice);
  }

  @override
  void dispose() {
    if (Platform.isAndroid || Platform.isIOS) {
      detector.stopListening();
    }
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
              child: _buildAmountOfDice(faces: 6, minAmount: 1),
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
                    padding: const EdgeInsets.all(12.0),
                    child: ElevatedButton(
                      onPressed: _rollDice,
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
          )
        ],
      ),
    );
  }

  NumberArrowsField _buildAmountOfDice({
    required int faces,
    int minAmount = 0,
    int maxAmount = 12,
  }) {
    return NumberArrowsField(
      minAmount: minAmount,
      maxAmount: maxAmount,
      currentAmount: dices.dicesWithFaces(faces),
      onAmountChange: (isIncreasing) {
        if (isIncreasing) {
          Dice newDice = Dice(faces: faces);
          setState(() {
            dices.dices.add(newDice);
            if (dicesResult != null) {
              dicesResult!.dicesResult
                  .add(DiceResult(result: 0, dice: newDice));
            }
          });
        } else {
          setState(() {
            int indexToRemoveDice =
                dices.dices.lastIndexWhere((dice) => dice.faces == faces);
            dices.dices.removeAt(indexToRemoveDice);
            if (dicesResult != null) {
              int indexToRemoveResult = dicesResult!.dicesResult.lastIndexWhere(
                  (diceResult) => diceResult.dice.faces == faces);
              dicesResult!.dicesResult.removeAt(indexToRemoveResult);
            }
          });
        }
      },
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
