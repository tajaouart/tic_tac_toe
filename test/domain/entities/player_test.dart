import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/domain/entities/player.dart';

void main() {
  group('Player', () {
    test('opponent of X is O', () {
      expect(Player.x.opponent, Player.o);
    });

    test('opponent of O is X', () {
      expect(Player.o.opponent, Player.x);
    });

    test('opponent of none is none', () {
      expect(Player.none.opponent, Player.none);
    });

    test('symbol returns correct value', () {
      expect(Player.x.symbol, 'X');
      expect(Player.o.symbol, 'O');
      expect(Player.none.symbol, '');
    });
  });
}
