import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pomodoro/providers/settings_provider.dart';
import 'package:pomodoro/screens/pomodoro_screen.dart';
import 'package:pomodoro/theme/theme.dart';

double getResponsiveFontSize(BuildContext context, double baseFontSize) {
  final screenWidth = MediaQuery.of(context).size.width;
  const double scalingFactor = 2000;
  return screenWidth / scalingFactor * baseFontSize;
}

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String fontSelection = ref.watch(fontSelectionProvider);

    return MaterialApp(
      theme: ThemeData(
        textTheme: getCustomTextTheme(context, fontSelection),
      ),
      debugShowCheckedModeBanner: false,
      home: const PomodoroScreen(),
    );
  }
}
