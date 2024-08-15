import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pomodoro/providers/settings_provider.dart';
import 'package:pomodoro/screens/settings_screen.dart';
import 'package:pomodoro/theme/theme.dart';
import 'package:pomodoro/providers/timer_provider.dart';
import 'package:pomodoro/models/timer_model.dart';

final selectedTabProvider = StateProvider<int>((ref) => 0);

Map<ButtonState, String> buttonText = {
  ButtonState.initial: "START",
  ButtonState.started: "PAUSE",
  ButtonState.paused: "RESUME",
  ButtonState.finished: "RESTART",
};

class PomodoroScreen extends ConsumerWidget {
  const PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedTabProvider);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    List<String> tabTitles = ['pomodoro', 'short break', 'long break'];
    TimerModel time;
    StateNotifierProvider<TimerNotifier, TimerModel> timerProvider;
    int initTime;
    switch (selectedTab) {
      case 0:
        time = ref.watch(pomoTimerProvider);
        timerProvider = pomoTimerProvider;
        initTime = ref.watch(pomodoroInitProvider);
      case 1:
        time = ref.watch(shortTimerProvider);
        timerProvider = shortTimerProvider;
        initTime = ref.watch(shortBreakInitProvider);
      case 2:
        time = ref.watch(longTimerProvider);
        timerProvider = longTimerProvider;
        initTime = ref.watch(longBreakInitProvider);
      default:
        time = ref.watch(pomoTimerProvider);
        timerProvider = pomoTimerProvider;
        initTime = ref.watch(pomodoroInitProvider);
    }
    return Scaffold(
        backgroundColor: AppColors.backgroundDark,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.064,
                vertical: screenHeight * 0.047),
            decoration: const BoxDecoration(color: Color(0xFF1E213F)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'pomodoro',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFD7E0FF),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: screenHeight * 0.07),
                // Tab bar
                Container(
                  width: screenWidth * 0.87,
                  height: screenHeight * 0.09,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF161932),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(screenHeight * 0.04), //31.5
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(tabTitles.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          ref.read(selectedTabProvider.notifier).state = index;
                        },
                        child: Container(
                          width: screenWidth * 0.28,
                          height: screenHeight * 0.07,
                          decoration: ShapeDecoration(
                            color: selectedTab == index
                                ? colorMap[ref.watch(colorProvider)]
                                : Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(screenHeight * 0.04),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          alignment: Alignment.center,
                          child: Text(
                            tabTitles[index],
                            style: TextStyle(
                              color: selectedTab == index
                                  ? AppColors.textDark
                                  : AppColors.textFill.withOpacity(0.4),
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: screenHeight * 0.07),
                Flexible(
                  flex: 1,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return GestureDetector(
                        onTap: () {
                          if (time.buttonState == ButtonState.initial ||
                              time.buttonState == ButtonState.paused) {
                            ref.read(timerProvider.notifier).start();
                          } else if (time.buttonState == ButtonState.finished) {
                            ref.read(timerProvider.notifier).reset();
                            ref.read(timerProvider.notifier).start();
                          } else {
                            ref.read(timerProvider.notifier).pause();
                          }
                        },
                        child: Container(
                          width: constraints.maxWidth * 0.9,
                          height: constraints.maxWidth * 0.9,
                          child: Stack(
                            children: [
                              Container(
                                decoration: ShapeDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment(1, 1),
                                    end: Alignment(-1, -1),
                                    colors: [
                                      Color(0xFF2D325A),
                                      Color(0xFF0E1029)
                                    ],
                                  ),
                                  shape: const OvalBorder(),
                                  shadows: [
                                    BoxShadow(
                                      color: const Color(0xFF12152F),
                                      blurRadius: constraints.maxWidth * 0.266,
                                      offset: Offset(
                                          constraints.maxWidth * 0.133,
                                          constraints.maxWidth * 0.133),
                                    ),
                                    BoxShadow(
                                      color: const Color(0xFF272C5A),
                                      blurRadius: constraints.maxWidth * 0.266,
                                      offset: Offset(
                                          -constraints.maxWidth * 0.133,
                                          -constraints.maxWidth * 0.133),
                                    )
                                  ],
                                ),
                              ),
                              Center(
                                child: Container(
                                  width: constraints.maxWidth * 0.8,
                                  height: constraints.maxWidth * 0.8,
                                  decoration: const ShapeDecoration(
                                    color: Color(0xFF161932),
                                    shape: OvalBorder(),
                                  ),
                                ),
                              ),
                              Center(
                                child: SizedBox(
                                  width: constraints.maxWidth * (0.8 - 0.024),
                                  height: constraints.maxWidth * (0.8 - 0.024),
                                  child: CircularProgressIndicator(
                                    value: time.duration ~/ 60 == 0
                                        ? 0
                                        : (time.duration ~/ 60 + 1) / initTime,
                                    color: colorMap[ref.watch(colorProvider)],
                                    strokeWidth: constraints.maxWidth * 0.024,
                                    strokeCap: StrokeCap.round,
                                  ),
                                ),
                              ),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      time.timeLeft,
                                      style: TextStyle(
                                        color: const Color(0xFFD6E0FE),
                                        fontSize: constraints.maxWidth * 0.2,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      buttonText[time.buttonState]!,
                                      style: const TextStyle(
                                        color: Color(0xFFD7E0FF),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 13.12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.07),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: IconButton(
                    icon: const Icon(
                      Icons.settings,
                      color: AppColors.textFill,
                      size: 32,
                    ),
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) {
                          return const SettingsScreen();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
