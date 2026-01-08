// Custom exceptions for the application.
//
// These exceptions represent specific error conditions that can occur
// in the data layer (repositories, services, data sources).

/// Base exception for all storage-related errors.
sealed class StorageException implements Exception {
  final String message;
  final Object? originalError;

  const StorageException(this.message, [this.originalError]);

  @override
  String toString() => 'StorageException: $message';
}

/// Thrown when data cannot be read from storage.
class StorageReadException extends StorageException {
  const StorageReadException(super.message, [super.originalError]);

  @override
  String toString() => 'StorageReadException: $message';
}

/// Thrown when data cannot be written to storage.
class StorageWriteException extends StorageException {
  const StorageWriteException(super.message, [super.originalError]);

  @override
  String toString() => 'StorageWriteException: $message';
}

/// Thrown when data format is invalid or corrupted.
class StorageFormatException extends StorageException {
  const StorageFormatException(super.message, [super.originalError]);

  @override
  String toString() => 'StorageFormatException: $message';
}

/// Base exception for game-related errors.
sealed class GameException implements Exception {
  final String message;

  const GameException(this.message);

  @override
  String toString() => 'GameException: $message';
}

/// Thrown when an invalid move is attempted.
class InvalidMoveException extends GameException {
  final int cellIndex;

  const InvalidMoveException(this.cellIndex, String message) : super(message);

  @override
  String toString() => 'InvalidMoveException: $message (cell: $cellIndex)';
}

/// Thrown when a game operation is performed on a finished game.
class GameOverException extends GameException {
  const GameOverException() : super('Cannot perform action on a finished game');

  @override
  String toString() => 'GameOverException: $message';
}
