import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tic_tac_toe/domain/entities/game_state.dart';

part 'game_state_bloc.freezed.dart';

@freezed
class GameBlocState with _$GameBlocState {
  const factory GameBlocState.initial() = GameInitial;

  const factory GameBlocState.inProgress({
    required Game game,
    @Default(false) bool isAiThinking,
    /// Tracks whether the game result has been recorded to prevent duplicates.
    @Default(false) bool resultRecorded,
  }) = GameInProgress;
}
