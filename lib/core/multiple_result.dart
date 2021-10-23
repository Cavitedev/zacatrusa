library multiple_result;

import 'package:meta/meta.dart';

/// Base Either class
///
/// Receives two values [L] and [R]
/// as [L] is an left and [R] is a right.
@sealed
abstract class Either<L, R> {
  /// Default constructor.
  const Either();

  /// Returns the current result.
  ///
  /// It may be a [Right] or an [Left].
  /// Check with
  /// ```dart
  ///   result.isRight();
  /// ```
  /// or
  /// ```dart
  ///   result.isLeft();
  /// ```
  ///
  /// before casting the value;
  dynamic get();

  /// Returns the value of [R].
  R? getRight();

  /// Returns the value of [L].
  L? getLeft();

  /// Returns true if the current result is an [Left].
  bool isLeft();

  /// Returns true if the current result is a [right].
  bool isRight();

  /// Return the result in one of these functions.
  ///
  /// if the result is an left, it will be returned in
  /// [whenLeft],
  /// if it is a right it will be returned in [whenRight].
  W when<W>(
    W Function(L left) whenLeft,
    W Function(R right) whenRight,
  );

}

/// Right Result.
///
/// return it when the result of a [Either] is
/// the expected value.
@immutable
class Right<L, R> implements Either<L, R> {
  /// Receives the [R] param as
  /// the rightful result.
  const Right(
    this._right,
  );

  final R _right;

  @override
  R get() {
    return _right;
  }

  @override
  bool isLeft() => false;

  @override
  bool isRight() => true;

  @override
  int get hashCode => _right.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Right && other._right == _right;

  @override
  W when<W>(
    W Function(L left) whenLeft,
    W Function(R right) whenRight,
  ) {
    return whenRight(_right);
  }

  @override
  L? getLeft() => null;

  @override
  R? getRight() => _right;

  @override
  String toString() {
    return 'Right{$_right}';
  }
}

/// Left Result.
///
/// return it when the result of a [Either] is
/// not the expected value.
@immutable
class Left<L, R> implements Either<L, R> {
  /// Receives the [L] param as
  /// the left result.
  const Left(this._left);

  final L _left;

  @override
  L get() {
    return _left;
  }

  @override
  bool isLeft() => true;

  @override
  bool isRight() => false;

  @override
  int get hashCode => _left.hashCode;

  @override
  bool operator ==(Object other) => other is Left && other._left == _left;

  @override
  W when<W>(
    W Function(L left) whenLeft,
    W Function(R right) whenRight,
  ) {
    return whenLeft(_left);
  }

  @override
  L? getLeft() => _left;

  @override
  R? getRight() => null;

  @override
  String toString() {
    return 'Left{$_left}';
  }
}

/// Default right class.
///
/// Instead of returning void, as
/// ```dart
///   Result<Exception, void>
/// ```
/// return
/// ```dart
///   Result<Exception, RightResult>
/// ```
class RightResult {
  const RightResult._internal();
}

/// Default right case.
const right = RightResult._internal();