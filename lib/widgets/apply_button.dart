import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro/providers/settings_provider.dart';
import 'package:pomodoro/providers/timer_provider.dart';

class ApplyButton extends ConsumerWidget {
  const ApplyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final buttonWidth = screenWidth * 0.37;
    final buttonHeight = screenHeight * 0.08;
    final buttonTop = screenHeight * 0.78;
    final buttonLeft = screenWidth * 0.25;

    return Positioned(
      left: buttonLeft,
      top: buttonTop,
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: ElevatedButton(
                onPressed: () {
                  ref.read(pomodoroInitProvider.notifier).state =
                      ref.read(tempPomodoroInitProvider);
                  ref.read(shortBreakInitProvider.notifier).state =
                      ref.read(tempShortBreakInitProvider);
                  ref.read(longBreakInitProvider.notifier).state =
                      ref.read(tempLongBreakInitProvider);
                  ref.read(colorProvider.notifier).state =
                      ref.read(tempColorProvider);
                  ref.read(fontSelectionProvider.notifier).state =
                      ref.read(tempFontSelectionProvider);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorMap[ref.watch(colorProvider)],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26.50),
                  ),
                  fixedSize: Size(buttonWidth,
                      buttonHeight), // Width and Height of the button
                ),
                child: Text(
                  'Apply',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.042,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
