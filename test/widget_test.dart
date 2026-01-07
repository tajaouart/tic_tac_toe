import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/injection/injection.dart';
import 'package:tic_tac_toe/main.dart';

void main() {
  setUpAll(() {
    configureDependencies();
  });

  testWidgets('App renders game page', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const TicTacToeApp());
    await tester.pumpAndSettle();

    expect(find.text('Tic Tac Toe'), findsOneWidget);
  });
}
