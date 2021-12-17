import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:shake/shake.dart';
import 'package:zacatrusa/game_board/presentation/dice/widgets/dice_button_with_layout.dart';
import 'package:zacatrusa/shortcuts/shortcuts.dart';

import '../../../constants/app_margins_and_sizes.dart';
import '../../domain/dice/dice.dart';
import 'widgets/dice_arrows_field.dart';
import 'widgets/dice_result.dart';

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
  }

  @override
  void dispose() {
    if (Platform.isAndroid || Platform.isIOS) {
      detector.stopListening();
    }
    super.dispose();
  }

  Future<void> _checkVibration() async {
    if (Platform.isAndroid || Platform.isIOS) {
      canVibrate = await Vibrate.canVibrate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <ShortcutActivator, Intent>{
        LogicalKeySet(LogicalKeyboardKey.keyR): const DiceIntent(),
        LogicalKeySet(LogicalKeyboardKey.keyD): const DiceIntent(),
        LogicalKeySet(LogicalKeyboardKey.f5): const DiceIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          DiceIntent: CallbackAction<DiceIntent>(onInvoke: (DiceIntent intent) {
            _rollDice();
          })
        },
        child: Focus(
          autofocus: true,
          child: Scaffold(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: generalPadding),
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
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
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
                DiceButtonWithLayout(
                  rollDice: _rollDice,
                )
              ],
            ),
          ),
        ),
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
