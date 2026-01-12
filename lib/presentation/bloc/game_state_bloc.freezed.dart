// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$GameBlocState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Game game, bool isAiThinking, bool resultRecorded)
    inProgress,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Game game, bool isAiThinking, bool resultRecorded)?
    inProgress,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Game game, bool isAiThinking, bool resultRecorded)?
    inProgress,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GameInitial value) initial,
    required TResult Function(GameInProgress value) inProgress,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GameInitial value)? initial,
    TResult? Function(GameInProgress value)? inProgress,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GameInitial value)? initial,
    TResult Function(GameInProgress value)? inProgress,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameBlocStateCopyWith<$Res> {
  factory $GameBlocStateCopyWith(
    GameBlocState value,
    $Res Function(GameBlocState) then,
  ) = _$GameBlocStateCopyWithImpl<$Res, GameBlocState>;
}

/// @nodoc
class _$GameBlocStateCopyWithImpl<$Res, $Val extends GameBlocState>
    implements $GameBlocStateCopyWith<$Res> {
  _$GameBlocStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameBlocState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$GameInitialImplCopyWith<$Res> {
  factory _$$GameInitialImplCopyWith(
    _$GameInitialImpl value,
    $Res Function(_$GameInitialImpl) then,
  ) = __$$GameInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GameInitialImplCopyWithImpl<$Res>
    extends _$GameBlocStateCopyWithImpl<$Res, _$GameInitialImpl>
    implements _$$GameInitialImplCopyWith<$Res> {
  __$$GameInitialImplCopyWithImpl(
    _$GameInitialImpl _value,
    $Res Function(_$GameInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GameBlocState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GameInitialImpl implements GameInitial {
  const _$GameInitialImpl();

  @override
  String toString() {
    return 'GameBlocState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GameInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Game game, bool isAiThinking, bool resultRecorded)
    inProgress,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Game game, bool isAiThinking, bool resultRecorded)?
    inProgress,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Game game, bool isAiThinking, bool resultRecorded)?
    inProgress,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GameInitial value) initial,
    required TResult Function(GameInProgress value) inProgress,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GameInitial value)? initial,
    TResult? Function(GameInProgress value)? inProgress,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GameInitial value)? initial,
    TResult Function(GameInProgress value)? inProgress,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class GameInitial implements GameBlocState {
  const factory GameInitial() = _$GameInitialImpl;
}

/// @nodoc
abstract class _$$GameInProgressImplCopyWith<$Res> {
  factory _$$GameInProgressImplCopyWith(
    _$GameInProgressImpl value,
    $Res Function(_$GameInProgressImpl) then,
  ) = __$$GameInProgressImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Game game, bool isAiThinking, bool resultRecorded});

  $GameCopyWith<$Res> get game;
}

/// @nodoc
class __$$GameInProgressImplCopyWithImpl<$Res>
    extends _$GameBlocStateCopyWithImpl<$Res, _$GameInProgressImpl>
    implements _$$GameInProgressImplCopyWith<$Res> {
  __$$GameInProgressImplCopyWithImpl(
    _$GameInProgressImpl _value,
    $Res Function(_$GameInProgressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GameBlocState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? game = null,
    Object? isAiThinking = null,
    Object? resultRecorded = null,
  }) {
    return _then(
      _$GameInProgressImpl(
        game: null == game
            ? _value.game
            : game // ignore: cast_nullable_to_non_nullable
                  as Game,
        isAiThinking: null == isAiThinking
            ? _value.isAiThinking
            : isAiThinking // ignore: cast_nullable_to_non_nullable
                  as bool,
        resultRecorded: null == resultRecorded
            ? _value.resultRecorded
            : resultRecorded // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }

  /// Create a copy of GameBlocState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GameCopyWith<$Res> get game {
    return $GameCopyWith<$Res>(_value.game, (value) {
      return _then(_value.copyWith(game: value));
    });
  }
}

/// @nodoc

class _$GameInProgressImpl implements GameInProgress {
  const _$GameInProgressImpl({
    required this.game,
    this.isAiThinking = false,
    this.resultRecorded = false,
  });

  @override
  final Game game;
  @override
  @JsonKey()
  final bool isAiThinking;

  /// Tracks whether the game result has been recorded to prevent duplicates.
  @override
  @JsonKey()
  final bool resultRecorded;

  @override
  String toString() {
    return 'GameBlocState.inProgress(game: $game, isAiThinking: $isAiThinking, resultRecorded: $resultRecorded)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameInProgressImpl &&
            (identical(other.game, game) || other.game == game) &&
            (identical(other.isAiThinking, isAiThinking) ||
                other.isAiThinking == isAiThinking) &&
            (identical(other.resultRecorded, resultRecorded) ||
                other.resultRecorded == resultRecorded));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, game, isAiThinking, resultRecorded);

  /// Create a copy of GameBlocState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameInProgressImplCopyWith<_$GameInProgressImpl> get copyWith =>
      __$$GameInProgressImplCopyWithImpl<_$GameInProgressImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Game game, bool isAiThinking, bool resultRecorded)
    inProgress,
  }) {
    return inProgress(game, isAiThinking, resultRecorded);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Game game, bool isAiThinking, bool resultRecorded)?
    inProgress,
  }) {
    return inProgress?.call(game, isAiThinking, resultRecorded);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Game game, bool isAiThinking, bool resultRecorded)?
    inProgress,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress(game, isAiThinking, resultRecorded);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GameInitial value) initial,
    required TResult Function(GameInProgress value) inProgress,
  }) {
    return inProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GameInitial value)? initial,
    TResult? Function(GameInProgress value)? inProgress,
  }) {
    return inProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GameInitial value)? initial,
    TResult Function(GameInProgress value)? inProgress,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress(this);
    }
    return orElse();
  }
}

abstract class GameInProgress implements GameBlocState {
  const factory GameInProgress({
    required final Game game,
    final bool isAiThinking,
    final bool resultRecorded,
  }) = _$GameInProgressImpl;

  Game get game;
  bool get isAiThinking;

  /// Tracks whether the game result has been recorded to prevent duplicates.
  bool get resultRecorded;

  /// Create a copy of GameBlocState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameInProgressImplCopyWith<_$GameInProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
