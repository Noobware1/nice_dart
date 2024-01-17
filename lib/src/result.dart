
/// A discriminated union that encapsulates a successful outcome with a value of type T or a failure with an arbitrary Exception exception.
class Result<T> {
  final dynamic value;
  Result(this.value);

  /// Returns true if this instance represents a successful outcome. In this case isFailure returns false.
  bool get isSuccess => value is! Failure;

  /// Returns true if this instance represents a failed outcome. In this case isSuccess returns false.
  bool get isFailure => value is Failure;

  /// Returns the encapsulated value if this instance represents success or null if it is failure.
  /// This function is a shorthand for getOrElse { null } (see getOrElse) or fold(onSuccess = { it }, onFailure = { null }) (see fold).
  T? getOrNull() {
    return isFailure ? null : value as T;
  }

  /// Returns the encapsulated Throwable exception if this instance represents failure or null if it is success.
  /// This function is a shorthand for fold(onSuccess = { null }, onFailure = { it }) (see fold).
  Exception? exceptionOrNull() {
    return isSuccess ? null : value.exception;
  }

  /// Returns a string Success(v) if this instance represents success where v is a string representation of the value or a string Failure(x) if it is failure where x is a string representation of the exception.
  @override
  String toString() {
    if (isFailure) {
      return value.toString();
    }
    return 'Success($value)';
  }

  static Result<T> success<T>(T value) {
    return Result(value);
  }

  static Result<T> failure<T>(Exception exception) {
    return Result(_createFailure(exception));
  }
}

sealed class Failure {
  final Exception exception;

  Failure(this.exception);
}

class _Failure extends Failure {
  _Failure(super.exception);

  @override
  bool operator ==(Object other) {
    return other is Failure && other.exception == exception;
  }

  @override
  int get hashCode => exception.hashCode;

  @override
  String toString() {
    return 'Failure{exception: $exception}';
  }
}

Failure _createFailure(Exception exception) {
  return _Failure(exception);
}

extension<T> on Result<T> {
  void throwOnFailure() {
    if (isFailure) {
      throw value.exception;
    }
  }
}

/// Calls the specified function block and returns its encapsulated result if invocation was successful, catching any Throwable exception that was thrown from the block function execution and encapsulating it as a failure.
Result<R> runCatching<R>(R Function() block) => _runCatching(block);

extension RunCatching<R> on R {
  /// Calls the specified function block and returns its encapsulated result if invocation was successful, catching any Throwable exception that was thrown from the block function execution and encapsulating it as a failure.
  Result<R> runCatching(R Function() block) {
    return _runCatching(block);
  }
}

Result<R> _runCatching<R>(R Function() block) {
  try {
    return Result.success(block());
  } catch (e) {
    return Result.failure(e is Exception ? e : Exception(e.toString()));
  }
}

extension GetOrThrow<T> on Result<T> {
  /// Returns the encapsulated value if this instance represents success or throws the encapsulated Throwable exception if it is failure.
  /// This function is a shorthand for getOrElse { throw it } (see getOrElse).
  T getOrThrow() {
    throwOnFailure();
    return value as T;
  }
}

extension GetOrElse<T> on Result<T> {
  /// Returns the encapsulated value if this instance represents success or the result of onFailure function for the encapsulated Throwable exception if it is failure.
  /// Note, that this function rethrows any Throwable exception thrown by onFailure function.
  /// This function is a shorthand for fold(onSuccess = { it }, onFailure = onFailure) (see fold).
  T getOrElse(T Function(Exception exception) onFailure) {
    if (isSuccess) return value as T;
    return onFailure(exceptionOrNull()!);
  }
}

extension GetOrDefault<T> on Result<T> {
  /// Returns the encapsulated value if this instance represents success or the defaultValue if it is failure.
  /// This function is a shorthand for getOrElse { defaultValue } (see getOrElse).
  T getOrDefault(T defaultValue) {
    if (isFailure) return defaultValue;
    return value as T;
  }
}

extension Fold<T> on Result<T> {
  /// Returns the result of onSuccess for the encapsulated value if this instance represents success or the result of onFailure function for the encapsulated Throwable exception if it is failure.
  /// Note, that this function rethrows any Throwable exception thrown by onSuccess or by onFailure function.
  R fold<R>(
    R Function(T value) onSuccess,
    R Function(Exception exception) onFailure,
  ) {
    if (isFailure) {
      return onFailure(exceptionOrNull()!);
    }
    return onSuccess(value as T);
  }
}

extension Map<T> on Result<T> {
  /// Returns the encapsulated result of the given transform function applied to the encapsulated value if this instance represents success or the original encapsulated Throwable exception if it is failure.
  /// Note, that this function rethrows any Throwable exception thrown by transform function. See mapCatching for an alternative that encapsulates exceptions.

  Result<R> map<R>(R Function(T value) transform) {
    if (isSuccess) return Result.success(transform(value as T));
    return Result(value);
  }

  /// Returns the encapsulated result of the given transform function applied to the encapsulated value if this instance represents success or the original encapsulated Throwable exception if it is failure.
  /// This function catches any Throwable exception thrown by transform function and encapsulates it as a failure. See map for an alternative that rethrows exceptions from transform function.
  Result<R> mapCatching<R>(R Function(T value) transform) {
    if (isSuccess) return runCatching(() => transform(value as T));
    return Result(value);
  }
}

extension Recover<T> on Result<T> {
  /// Returns the encapsulated result of the given transform function applied to the encapsulated Throwable exception if this instance represents failure or the original encapsulated value if it is success.
  /// Note, that this function rethrows any Throwable exception thrown by transform function. See recoverCatching for an alternative that encapsulates exceptions.
  Result<R> recover<R>(R Function(Exception exception) transform) {
    if (isSuccess) return Result.success(value);
    return Result.success(transform(exceptionOrNull()!));
  }

  /// Returns the encapsulated result of the given transform function applied to the encapsulated Throwable exception if this instance represents failure or the original encapsulated value if it is success.
  /// This function catches any Throwable exception thrown by transform function and encapsulates it as a failure. See recover for an alternative that rethrows exceptions.
  Result<R> recoverCatching<R>(R Function(Exception exception) transform) {
    if (isSuccess) return Result.success(value);
    return runCatching(() => transform(exceptionOrNull()!));
  }
}
