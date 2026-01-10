// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_statistics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$GameStatistics {
  int get wins => throw _privateConstructorUsedError;
  int get losses => throw _privateConstructorUsedError;
  int get draws => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  int get bestStreak => throw _privateConstructorUsedError;

  /// Create a copy of GameStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameStatisticsCopyWith<GameStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStatisticsCopyWith<$Res> {
  factory $GameStatisticsCopyWith(
    GameStatistics value,
    $Res Function(GameStatistics) then,
  ) = _$GameStatisticsCopyWithImpl<$Res, GameStatistics>;
  @useResult
  $Res call({
    int wins,
    int losses,
    int draws,
    int currentStreak,
    int bestStreak,
  });
}

/// @nodoc
class _$GameStatisticsCopyWithImpl<$Res, $Val extends GameStatistics>
    implements $GameStatisticsCopyWith<$Res> {
  _$GameStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wins = null,
    Object? losses = null,
    Object? draws = null,
    Object? currentStreak = null,
    Object? bestStreak = null,
  }) {
    return _then(
      _value.copyWith(
            wins: null == wins
                ? _value.wins
                : wins // ignore: cast_nullable_to_non_nullable
                      as int,
            losses: null == losses
                ? _value.losses
                : losses // ignore: cast_nullable_to_non_nullable
                      as int,
            draws: null == draws
                ? _value.draws
                : draws // ignore: cast_nullable_to_non_nullable
                      as int,
            currentStreak: null == currentStreak
                ? _value.currentStreak
                : currentStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            bestStreak: null == bestStreak
                ? _value.bestStreak
                : bestStreak // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GameStatisticsImplCopyWith<$Res>
    implements $GameStatisticsCopyWith<$Res> {
  factory _$$GameStatisticsImplCopyWith(
    _$GameStatisticsImpl value,
    $Res Function(_$GameStatisticsImpl) then,
  ) = __$$GameStatisticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int wins,
    int losses,
    int draws,
    int currentStreak,
    int bestStreak,
  });
}

/// @nodoc
class __$$GameStatisticsImplCopyWithImpl<$Res>
    extends _$GameStatisticsCopyWithImpl<$Res, _$GameStatisticsImpl>
    implements _$$GameStatisticsImplCopyWith<$Res> {
  __$$GameStatisticsImplCopyWithImpl(
    _$GameStatisticsImpl _value,
    $Res Function(_$GameStatisticsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GameStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wins = null,
    Object? losses = null,
    Object? draws = null,
    Object? currentStreak = null,
    Object? bestStreak = null,
  }) {
    return _then(
      _$GameStatisticsImpl(
        wins: null == wins
            ? _value.wins
            : wins // ignore: cast_nullable_to_non_nullable
                  as int,
        losses: null == losses
            ? _value.losses
            : losses // ignore: cast_nullable_to_non_nullable
                  as int,
        draws: null == draws
            ? _value.draws
            : draws // ignore: cast_nullable_to_non_nullable
                  as int,
        currentStreak: null == currentStreak
            ? _value.currentStreak
            : currentStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        bestStreak: null == bestStreak
            ? _value.bestStreak
            : bestStreak // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$GameStatisticsImpl extends _GameStatistics {
  const _$GameStatisticsImpl({
    this.wins = 0,
    this.losses = 0,
    this.draws = 0,
    this.currentStreak = 0,
    this.bestStreak = 0,
  }) : super._();

  @override
  @JsonKey()
  final int wins;
  @override
  @JsonKey()
  final int losses;
  @override
  @JsonKey()
  final int draws;
  @override
  @JsonKey()
  final int currentStreak;
  @override
  @JsonKey()
  final int bestStreak;

  @override
  String toString() {
    return 'GameStatistics(wins: $wins, losses: $losses, draws: $draws, currentStreak: $currentStreak, bestStreak: $bestStreak)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStatisticsImpl &&
            (identical(other.wins, wins) || other.wins == wins) &&
            (identical(other.losses, losses) || other.losses == losses) &&
            (identical(other.draws, draws) || other.draws == draws) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.bestStreak, bestStreak) ||
                other.bestStreak == bestStreak));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, wins, losses, draws, currentStreak, bestStreak);

  /// Create a copy of GameStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStatisticsImplCopyWith<_$GameStatisticsImpl> get copyWith =>
      __$$GameStatisticsImplCopyWithImpl<_$GameStatisticsImpl>(
        this,
        _$identity,
      );
}

abstract class _GameStatistics extends GameStatistics {
  const factory _GameStatistics({
    final int wins,
    final int losses,
    final int draws,
    final int currentStreak,
    final int bestStreak,
  }) = _$GameStatisticsImpl;
  const _GameStatistics._() : super._();

  @override
  int get wins;
  @override
  int get losses;
  @override
  int get draws;
  @override
  int get currentStreak;
  @override
  int get bestStreak;

  /// Create a copy of GameStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameStatisticsImplCopyWith<_$GameStatisticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
