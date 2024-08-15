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
    return Positioned(
      left: 94,
      top: 522,
      child: Container(
        width: 140,
        height: 53,
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
                  fixedSize:
                      const Size(140, 53), // Width and Height of the button
                ),
                child: const Text(
                  'Apply',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 0,
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
