import 'package:equatable/equatable.dart';

/// Abstract class representing a failure in the domain layer.
///
/// Failures are used to communicate error conditions from the data layer
/// to the presentation layer in a clean architecture pattern.
sealed class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Failure related to storage operations.
class StorageFailure extends Failure {
  const StorageFailure(super.message);
}

/// Failure when settings cannot be loaded.
class SettingsLoadFailure extends StorageFailure {
  const SettingsLoadFailure() : super('Failed to load settings');
}

/// Failure when settings cannot be saved.
class SettingsSaveFailure extends StorageFailure {
  const SettingsSaveFailure() : super('Failed to save settings');
}

/// Failure when statistics cannot be loaded.
class StatisticsLoadFailure extends StorageFailure {
  const StatisticsLoadFailure() : super('Failed to load statistics');
}

/// Failure when statistics cannot be saved.
class StatisticsSaveFailure extends StorageFailure {
  const StatisticsSaveFailure() : super('Failed to save statistics');
}

/// Failure related to game operations.
class GameFailure extends Failure {
  const GameFailure(super.message);
}

/// Failure when an invalid move is attempted.
class InvalidMoveFailure extends GameFailure {
  const InvalidMoveFailure() : super('Invalid move attempted');
}
