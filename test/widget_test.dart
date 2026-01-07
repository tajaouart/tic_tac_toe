import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/injection/injection.dart';
import 'package:tic_tac_toe/main.dart';

void main() {
  setUpAll(() {
    configureDependencies();
  });

  testWidgets('App renders game page', (WidgetTester tester) async {
    await tester.pumpWidget(const TicTacToeApp());
    await tester.pumpAndSettle();

    expect(find.text('Tic Tac Toe'), findsOneWidget);
  });
}
