import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pomodoro/providers/timer_provider.dart';
import 'package:pomodoro/widgets/apply_button.dart';
import 'package:pomodoro/widgets/font_buttons.dart';
import 'package:pomodoro/widgets/stepper.dart';
import 'package:pomodoro/providers/settings_provider.dart';
import 'package:pomodoro/widgets/color_buttons.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          children: [
            Container(
              width: 327,
              height: 575,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: Stack(
                children: [
                  //White background
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 327,
                      height: 549,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  const ApplyButton(),
                  //Settings title and the close button
                  Positioned(
                    left: 24,
                    top: 24,
                    right: 24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Settings',
                          style: TextStyle(
                            color: Color(0xFF161932),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height:
                                1.2, // Adjust this to match the spacing you need
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            ref.read(tempPomodoroInitProvider.notifier).state =
                                ref.read(pomodoroInitProvider);
                            ref
                                .read(tempShortBreakInitProvider.notifier)
                                .state = ref.read(shortBreakInitProvider);
                            ref.read(tempLongBreakInitProvider.notifier).state =
                                ref.read(longBreakInitProvider);
                            ref.read(tempColorProvider.notifier).state =
                                ref.read(colorProvider);
                            ref.read(tempFontSelectionProvider.notifier).state =
                                ref.read(fontSelectionProvider);
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 24.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const ColorButtons(),
                  // Time sections
                  Positioned(
                    left: 163,
                    top: 126,
                    child: Container(
                      width: 140,
                      height: 40,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 140,
                              height: 40,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFEFF1FA),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            top: 8,
                            child: CustomStepper(
                                timerProvider: tempPomodoroInitProvider),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 23,
                    top: 141,
                    child: Opacity(
                      opacity: 0.40,
                      child: Text(
                        'pomodoro',
                        style: TextStyle(
                          color: Color(0xFF1E213F),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 23,
                    top: 174,
                    child: Container(
                      width: 280,
                      height: 40,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 140,
                            top: 0,
                            child: Container(
                              width: 140,
                              height: 40,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 140,
                                      height: 40,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFEFF1FA),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 16,
                                    top: 8,
                                    child: CustomStepper(
                                        timerProvider:
                                            tempShortBreakInitProvider),
                                  ),
                                  Positioned(
                                    left: 112,
                                    top: 12,
                                    child: Container(width: 12, height: 17),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Positioned(
                            left: 0,
                            top: 15,
                            child: Opacity(
                              opacity: 0.40,
                              child: Text(
                                'short break',
                                style: TextStyle(
                                  color: Color(0xFF1E213F),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 23,
                    top: 222,
                    child: Container(
                      width: 280,
                      height: 40,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 140,
                            top: 0,
                            child: Container(
                              width: 140,
                              height: 40,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 140,
                                      height: 40,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFEFF1FA),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 16,
                                    top: 8,
                                    child: CustomStepper(
                                      timerProvider: tempLongBreakInitProvider,
                                    ),
                                  ),
                                  Positioned(
                                    left: 112,
                                    top: 12,
                                    child: Container(width: 12, height: 17),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Positioned(
                            left: 0,
                            top: 15,
                            child: Opacity(
                              opacity: 0.40,
                              child: Text(
                                'long break',
                                style: TextStyle(
                                  color: Color(0xFF1E213F),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 93,
                    top: 97,
                    child: Text(
                      'TIME (MINUTES)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF161932),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        height: 0,
                        letterSpacing: 4.23,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 143,
                    top: 311,
                    child: Text(
                      'FONT',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF161932),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        height: 0,
                        letterSpacing: 4.23,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 136,
                    top: 421,
                    child: Text(
                      'COLOR',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF161932),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        height: 0,
                        letterSpacing: 4.23,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 88,
                    top: 340,
                    child: Container(
                      width: 152,
                      height: 40,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FontButton(
                            fontFamily: 'Kumbh Sans',
                            backgroundColor: Color(0xFFEEF1F9),
                            textColor: Color(0xFF1E213F),
                          ),
                          FontButton(
                            fontFamily: 'Roboto Slab',
                            backgroundColor: Color(0xFFEEF1F9),
                            textColor: Color(0xFF1E213F),
                          ),
                          FontButton(
                            fontFamily: 'Space Mono',
                            backgroundColor: Color(0xFFEEF1F9),
                            textColor: Color(0xFF1E213F),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 72,
                    child: Container(
                      width: 327,
                      height: 1,
                      decoration: const BoxDecoration(color: Color(0xFFE2E1E1)),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    top: 286,
                    child: Container(
                      width: 280,
                      height: 1,
                      decoration: const BoxDecoration(color: Color(0xFFE2E1E1)),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    top: 286,
                    child: Container(
                      width: 280,
                      height: 1,
                      decoration: const BoxDecoration(color: Color(0xFFE2E1E1)),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    top: 404,
                    child: Container(
                      width: 280,
                      height: 1,
                      decoration: const BoxDecoration(color: Color(0xFFE2E1E1)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
