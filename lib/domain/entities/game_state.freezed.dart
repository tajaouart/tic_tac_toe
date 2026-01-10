// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Game {
  Board get board => throw _privateConstructorUsedError;
  Player get currentPlayer => throw _privateConstructorUsedError;
  GameStatus get status => throw _privateConstructorUsedError;
  List<int>? get winningLine => throw _privateConstructorUsedError;

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameCopyWith<Game> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameCopyWith<$Res> {
  factory $GameCopyWith(Game value, $Res Function(Game) then) =
      _$GameCopyWithImpl<$Res, Game>;
  @useResult
  $Res call({
    Board board,
    Player currentPlayer,
    GameStatus status,
    List<int>? winningLine,
  });

  $BoardCopyWith<$Res> get board;
}

/// @nodoc
class _$GameCopyWithImpl<$Res, $Val extends Game>
    implements $GameCopyWith<$Res> {
  _$GameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? board = null,
    Object? currentPlayer = null,
    Object? status = null,
    Object? winningLine = freezed,
  }) {
    return _then(
      _value.copyWith(
            board: null == board
                ? _value.board
                : board // ignore: cast_nullable_to_non_nullable
                      as Board,
            currentPlayer: null == currentPlayer
                ? _value.currentPlayer
                : currentPlayer // ignore: cast_nullable_to_non_nullable
                      as Player,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as GameStatus,
            winningLine: freezed == winningLine
                ? _value.winningLine
                : winningLine // ignore: cast_nullable_to_non_nullable
                      as List<int>?,
          )
          as $Val,
    );
  }

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BoardCopyWith<$Res> get board {
    return $BoardCopyWith<$Res>(_value.board, (value) {
      return _then(_value.copyWith(board: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameImplCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$$GameImplCopyWith(
    _$GameImpl value,
    $Res Function(_$GameImpl) then,
  ) = __$$GameImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Board board,
    Player currentPlayer,
    GameStatus status,
    List<int>? winningLine,
  });

  @override
  $BoardCopyWith<$Res> get board;
}

/// @nodoc
class __$$GameImplCopyWithImpl<$Res>
    extends _$GameCopyWithImpl<$Res, _$GameImpl>
    implements _$$GameImplCopyWith<$Res> {
  __$$GameImplCopyWithImpl(_$GameImpl _value, $Res Function(_$GameImpl) _then)
    : super(_value, _then);

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? board = null,
    Object? currentPlayer = null,
    Object? status = null,
    Object? winningLine = freezed,
  }) {
    return _then(
      _$GameImpl(
        board: null == board
            ? _value.board
            : board // ignore: cast_nullable_to_non_nullable
                  as Board,
        currentPlayer: null == currentPlayer
            ? _value.currentPlayer
            : currentPlayer // ignore: cast_nullable_to_non_nullable
                  as Player,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as GameStatus,
        winningLine: freezed == winningLine
            ? _value._winningLine
            : winningLine // ignore: cast_nullable_to_non_nullable
                  as List<int>?,
      ),
    );
  }
}

/// @nodoc

class _$GameImpl extends _Game {
  const _$GameImpl({
    required this.board,
    required this.currentPlayer,
    required this.status,
    final List<int>? winningLine,
  }) : _winningLine = winningLine,
       super._();

  @override
  final Board board;
  @override
  final Player currentPlayer;
  @override
  final GameStatus status;
  final List<int>? _winningLine;
  @override
  List<int>? get winningLine {
    final value = _winningLine;
    if (value == null) return null;
    if (_winningLine is EqualUnmodifiableListView) return _winningLine;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Game(board: $board, currentPlayer: $currentPlayer, status: $status, winningLine: $winningLine)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameImpl &&
            (identical(other.board, board) || other.board == board) &&
            (identical(other.currentPlayer, currentPlayer) ||
                other.currentPlayer == currentPlayer) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(
              other._winningLine,
              _winningLine,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    board,
    currentPlayer,
    status,
    const DeepCollectionEquality().hash(_winningLine),
  );

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameImplCopyWith<_$GameImpl> get copyWith =>
      __$$GameImplCopyWithImpl<_$GameImpl>(this, _$identity);
}

abstract class _Game extends Game {
  const factory _Game({
    required final Board board,
    required final Player currentPlayer,
    required final GameStatus status,
    final List<int>? winningLine,
  }) = _$GameImpl;
  const _Game._() : super._();

  @override
  Board get board;
  @override
  Player get currentPlayer;
  @override
  GameStatus get status;
  @override
  List<int>? get winningLine;

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameImplCopyWith<_$GameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
