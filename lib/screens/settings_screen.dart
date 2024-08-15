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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          children: [
            Container(
              width: screenWidth * 0.87,
              height: screenHeight * 0.86,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: Stack(
                children: [
                  //White background
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: screenWidth * 0.87,
                      height: screenHeight * 0.82,
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
                    left: screenWidth * 0.064,
                    top: screenWidth * 0.064,
                    right: screenWidth * 0.064,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Settings',
                          style: TextStyle(
                            color: Color(0xFF161932),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
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
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                            size: screenWidth * 0.064,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const ColorButtons(),
                  // Time sections
                  Positioned(
                    left: screenWidth * 0.435,
                    top: screenHeight * 0.19,
                    child: Container(
                      width: screenWidth * 0.37,
                      height: screenHeight * 0.06,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: screenWidth * 0.37,
                              height: screenHeight * 0.06,
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
                  Positioned(
                    left: 23,
                    top: screenHeight * 0.21,
                    child: const Opacity(
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
                    top: screenHeight * 0.26,
                    child: Container(
                      width: screenWidth * 0.75,
                      height: screenHeight * 0.06,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: Stack(
                        children: [
                          Positioned(
                            left: screenWidth * 0.37,
                            top: 0,
                            child: Container(
                              width: screenWidth * 0.37,
                              height: screenHeight * 0.06,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: screenWidth * 0.37,
                                      height: screenHeight * 0.06,
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
                                    left: screenWidth * 0.31,
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
                    top: screenHeight * 0.33,
                    child: Container(
                      width: screenWidth * 0.75,
                      height: screenHeight * 0.06,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: Stack(
                        children: [
                          Positioned(
                            left: screenWidth * 0.37,
                            top: 0,
                            child: Container(
                              width: screenWidth * 0.37,
                              height: screenHeight * 0.06,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: screenWidth * 0.37,
                                      height: screenHeight * 0.06,
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
                                    left: screenWidth * 0.31,
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
                  Positioned(
                    left: screenWidth * 0.24,
                    top: screenHeight * 0.145,
                    child: const Text(
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
                  Positioned(
                    left: screenWidth * 0.37,
                    top: screenHeight * 0.465,
                    child: const Text(
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
                  Positioned(
                    left: screenWidth * 0.35,
                    top: screenHeight * 0.63,
                    child: const Text(
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
                    left: screenWidth * 0.24,
                    top: screenHeight * 0.51,
                    child: Container(
                      width: screenWidth * 0.4,
                      height: screenHeight * 0.06,
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
                    top: screenHeight * 0.11,
                    child: Container(
                      width: screenWidth * 0.87,
                      height: 1,
                      decoration: const BoxDecoration(color: Color(0xFFE2E1E1)),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    top: screenHeight * 0.43,
                    child: Container(
                      width: screenWidth * 0.75,
                      height: 1,
                      decoration: const BoxDecoration(color: Color(0xFFE2E1E1)),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    top: screenHeight * 0.43,
                    child: Container(
                      width: screenWidth * 0.75,
                      height: 1,
                      decoration: const BoxDecoration(color: Color(0xFFE2E1E1)),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    top: screenHeight * 0.61,
                    child: Container(
                      width: screenWidth * 0.75,
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
