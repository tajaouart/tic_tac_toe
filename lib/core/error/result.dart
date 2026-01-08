import 'package:tic_tac_toe/core/error/failures.dart';

/// A Result type that represents either a success with data or a failure.
///
/// This provides a functional approach to error handling, avoiding exceptions
/// in the domain layer and making error states explicit.
sealed class Result<T> {
  const Result();

  /// Returns true if this is a success result.
  bool get isSuccess => this is Success<T>;

  /// Returns true if this is a failure result.
  bool get isFailure => this is Fail<T>;

  /// Gets the value if success, throws if failure.
  T get value {
    return switch (this) {
      Success<T>(:final data) => data,
      Fail<T>(:final failure) => throw StateError('Cannot get value from failure: ${failure.message}'),
    };
  }

  /// Gets the failure if failed, throws if success.
  Failure get failure {
    return switch (this) {
      Success<T>() => throw StateError('Cannot get failure from success'),
      Fail<T>(:final failure) => failure,
    };
  }

  /// Maps the success value to a new type.
  Result<R> map<R>(R Function(T data) mapper) {
    return switch (this) {
      Success<T>(:final data) => Success(mapper(data)),
      Fail<T>(:final failure) => Fail(failure),
    };
  }

  /// Folds the result into a single value.
  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(Failure failure) onFailure,
  }) {
    return switch (this) {
      Success<T>(:final data) => onSuccess(data),
      Fail<T>(:final failure) => onFailure(failure),
    };
  }

  /// Returns the value or a default if failure.
  T getOrElse(T defaultValue) {
    return switch (this) {
      Success<T>(:final data) => data,
      Fail<T>() => defaultValue,
    };
  }
}

/// Represents a successful result with data.
class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);
}

/// Represents a failed result with a failure.
class Fail<T> extends Result<T> {
  @override
  final Failure failure;

  const Fail(this.failure);
}
