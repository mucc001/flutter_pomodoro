import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro/providers/settings_provider.dart';

class ColorButtons extends ConsumerWidget {
  const ColorButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedButtonIndex = ref.watch(tempColorProvider);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Adjust the size and positioning relative to the screen size
    final buttonSize = screenWidth * 0.1;
    final buttonSpacing = screenWidth * 0.04;

    // Calculate positions based on screen dimensions
    final leftPosition1 = screenWidth * 0.24;
    final leftPosition2 = leftPosition1 + buttonSize + buttonSpacing;
    final leftPosition3 = leftPosition2 + buttonSize + buttonSpacing;

    return Positioned(
      left: leftPosition1,
      top: screenHeight * 0.67,
      child: Container(
        width: buttonSize * 3 + buttonSpacing * 2,
        height: buttonSize,
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
                  width: buttonSize,
                  height: buttonSize,
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
              left: buttonSize + buttonSpacing,
              top: 0,
              child: GestureDetector(
                onTap: () {
                  ref.read(tempColorProvider.notifier).state = 1;
                },
                child: Container(
                  width: buttonSize,
                  height: buttonSize,
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
              left: 2 * (buttonSize + buttonSpacing),
              top: 0,
              child: GestureDetector(
                onTap: () {
                  ref.read(tempColorProvider.notifier).state = 2;
                },
                child: Container(
                  width: buttonSize,
                  height: buttonSize,
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
