import 'dart:math';

class Dices {
  Dices({required this.dices});

  List<Dice> dices;
  Random random = Random();

  DicesResult throwDices() {
    List<DiceResult> results =
        dices.map((dice) => dice.throwDice(random)).toList();
    return DicesResult(dicesResult: results);
  }
}

class Dice {
  int faces;

  Dice({
    required this.faces,
  });

  DiceResult throwDice(Random random) {
    return DiceResult(
      result: random.nextInt(faces) + 1,
      faces: faces,
    );
  }
}

class DiceResult {
  int result;
  int faces;

  DiceResult({
    required this.result,
    required this.faces,
  });
}

class DicesResult {
  DicesResult({
    required this.dicesResult,
  });

  List<DiceResult> dicesResult;

  int get total => dicesResult.fold(
      0, (previousValue, diceResult) => previousValue + diceResult.result);
}
