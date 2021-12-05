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

  int dicesWithFaces(int faces) {
    return dices.where((dice) => dice.faces == faces).length;
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
      dice: this,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Dice && runtimeType == other.runtimeType && faces == other.faces;

  @override
  int get hashCode => faces.hashCode;
}

class DiceResult {
  int result;
  final Dice dice;

  DiceResult({
    required this.result,
    required this.dice,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiceResult &&
          runtimeType == other.runtimeType &&
          result == other.result &&
          dice == other.dice;

  @override
  int get hashCode => result.hashCode ^ dice.hashCode;
}

class DicesResult {
  DicesResult({
    required this.dicesResult,
  });

  List<DiceResult> dicesResult;

  int get total => dicesResult.fold(
      0, (previousValue, diceResult) => previousValue + diceResult.result);
}
