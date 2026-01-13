import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:injectable/injectable.dart';

/// Service for playing game sound effects.
///
/// Accepts optional AudioPlayer instances for testing purposes.
@lazySingleton
class SoundService {
  final AudioPlayer _tapPlayer;
  final AudioPlayer _successPlayer;
  final AudioPlayer _lostPlayer;

  bool _isEnabled = true;

  /// Whether sounds are currently enabled.
  bool get isEnabled => _isEnabled;

  /// Creates a SoundService with default AudioPlayer instances.
  @factoryMethod
  static SoundService create() => SoundService._();

  /// Internal constructor for production use.
  SoundService._()
      : _tapPlayer = AudioPlayer(),
        _successPlayer = AudioPlayer(),
        _lostPlayer = AudioPlayer();

  /// Test constructor that accepts mock AudioPlayer instances.
  @visibleForTesting
  SoundService.test({
    required AudioPlayer tapPlayer,
    required AudioPlayer successPlayer,
    required AudioPlayer lostPlayer,
  })  : _tapPlayer = tapPlayer,
        _successPlayer = successPlayer,
        _lostPlayer = lostPlayer;

  /// Sets whether sounds are enabled.
  void setEnabled(bool enabled) {
    _isEnabled = enabled;
  }

  /// Plays the tap sound when a cell is tapped.
  Future<void> playTap() async {
    if (!_isEnabled) return;
    await _tapPlayer.play(AssetSource('sound/tap.wav'));
  }

  /// Plays the success sound when player wins.
  Future<void> playSuccess() async {
    if (!_isEnabled) return;
    await _successPlayer.play(AssetSource('sound/success.wav'));
  }

  /// Plays the lost sound when player loses.
  Future<void> playLost() async {
    if (!_isEnabled) return;
    await _lostPlayer.play(AssetSource('sound/lost.wav'));
  }

  /// Disposes all audio players.
  Future<void> dispose() async {
    await _tapPlayer.dispose();
    await _successPlayer.dispose();
    await _lostPlayer.dispose();
  }
}
