import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:pomodoro/screens/pomodoro_screen.dart';
import 'package:pomodoro/theme/theme.dart';

void main() {
  testGoldens('PomodoroScreen Golden Test', (WidgetTester tester) async {
    // Ensure the layout and rendering are properly initialized.
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: ThemeData(
        textTheme: getCustomTextTheme(),
      ),
          home: const PomodoroScreen(),
        ),
      ),
    );

    // Set the size of the screen for the golden test
    await tester.binding.setSurfaceSize(const Size(360, 640)); 

    // Wait for any pending animations or actions
    await tester.pumpAndSettle();

    // Capture the golden snapshot
    await expectLater(
      find.byType(PomodoroScreen),
      matchesGoldenFile('goldens/pomodoro_screen.png'),
    );
  });
}
