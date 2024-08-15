import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro/providers/settings_provider.dart';

class ColorButtons extends ConsumerWidget {
  const ColorButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedButtonIndex = ref.watch(tempColorProvider);

    return Positioned(
      left: 88,
      top: 450,
      child: Container(
        width: 152,
        height: 40,
        child: Stack(
          children: [
            // Button red
            Positioned(
              left: 0,
              top: 0,
              child: GestureDetector(
                onTap: () {
                  ref.read(tempColorProvider.notifier).state = 0;
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const ShapeDecoration(
                    color: Color(0xFFF87070),
                    shape: OvalBorder(),
                  ),
                  child: selectedButtonIndex == 0
                      ? const Icon(Icons.check, color: Colors.white)
                      : null,
                ),
              ),
            ),
            // Button blue
            Positioned(
              left: 56,
              top: 0,
              child: GestureDetector(
                onTap: () {
                  // Update the provider to indicate that button 2 is selected
                  ref.read(tempColorProvider.notifier).state = 1;
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF70F3F8),
                    shape: OvalBorder(),
                  ),
                  child: selectedButtonIndex == 1
                      ? const Icon(Icons.check, color: Colors.white)
                      : null,
                ),
              ),
            ),
            // Button pink
            Positioned(
              left: 112,
              top: 0,
              child: GestureDetector(
                onTap: () {
                  ref.read(tempColorProvider.notifier).state = 2;
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const ShapeDecoration(
                    color: Color(0xFFD881F8),
                    shape: OvalBorder(),
                  ),
                  child: selectedButtonIndex == 2
                      ? const Icon(Icons.check, color: Colors.white)
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
