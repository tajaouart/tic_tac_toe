import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tic_tac_toe/data/services/sound_service.dart';

class MockAudioPlayer extends Mock implements AudioPlayer {}

class FakeSource extends Fake implements Source {}

void main() {
  late MockAudioPlayer mockTapPlayer;
  late MockAudioPlayer mockSuccessPlayer;
  late MockAudioPlayer mockLostPlayer;
  late SoundService soundService;

  setUpAll(() {
    registerFallbackValue(FakeSource());
  });

  setUp(() {
    mockTapPlayer = MockAudioPlayer();
    mockSuccessPlayer = MockAudioPlayer();
    mockLostPlayer = MockAudioPlayer();

    when(() => mockTapPlayer.play(any())).thenAnswer((_) async {});
    when(() => mockSuccessPlayer.play(any())).thenAnswer((_) async {});
    when(() => mockLostPlayer.play(any())).thenAnswer((_) async {});
    when(() => mockTapPlayer.dispose()).thenAnswer((_) async {});
    when(() => mockSuccessPlayer.dispose()).thenAnswer((_) async {});
    when(() => mockLostPlayer.dispose()).thenAnswer((_) async {});

    soundService = SoundService.test(
      tapPlayer: mockTapPlayer,
      successPlayer: mockSuccessPlayer,
      lostPlayer: mockLostPlayer,
    );
  });

  group('SoundService', () {
    group('isEnabled', () {
      test('is true by default', () {
        expect(soundService.isEnabled, true);
      });

      test('can be set to false', () {
        soundService.setEnabled(false);
        expect(soundService.isEnabled, false);
      });

      test('can be toggled', () {
        soundService.setEnabled(false);
        soundService.setEnabled(true);
        expect(soundService.isEnabled, true);
      });
    });

    group('playTap', () {
      test('plays sound when enabled', () async {
        await soundService.playTap();

        verify(() => mockTapPlayer.play(any())).called(1);
      });

      test('does not play sound when disabled', () async {
        soundService.setEnabled(false);

        await soundService.playTap();

        verifyNever(() => mockTapPlayer.play(any()));
      });
    });

    group('playSuccess', () {
      test('plays sound when enabled', () async {
        await soundService.playSuccess();

        verify(() => mockSuccessPlayer.play(any())).called(1);
      });

      test('does not play sound when disabled', () async {
        soundService.setEnabled(false);

        await soundService.playSuccess();

        verifyNever(() => mockSuccessPlayer.play(any()));
      });
    });

    group('playLost', () {
      test('plays sound when enabled', () async {
        await soundService.playLost();

        verify(() => mockLostPlayer.play(any())).called(1);
      });

      test('does not play sound when disabled', () async {
        soundService.setEnabled(false);

        await soundService.playLost();

        verifyNever(() => mockLostPlayer.play(any()));
      });
    });

    group('dispose', () {
      test('disposes all audio players', () async {
        await soundService.dispose();

        verify(() => mockTapPlayer.dispose()).called(1);
        verify(() => mockSuccessPlayer.dispose()).called(1);
        verify(() => mockLostPlayer.dispose()).called(1);
      });
    });
  });
}
