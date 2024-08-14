import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    switch (selectedTab) {
      case 0:
        time = ref.watch(pomoTimerProvider);
        timerProvider = pomoTimerProvider;
      case 1:
        time = ref.watch(shortTimerProvider);
        timerProvider = shortTimerProvider;
      case 2:
        time = ref.watch(longTimerProvider);
        timerProvider = longTimerProvider;
      default:
        time = ref.watch(pomoTimerProvider);
        timerProvider = pomoTimerProvider;
    }
    return Scaffold(
        backgroundColor: AppColors.backgroundDark,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            decoration: BoxDecoration(color: Color(0xFF1E213F)),
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
                    fontFamily: 'Kumbh Sans',
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 57),
                Container(
                  decoration: ShapeDecoration(
                    color: const Color(0xFF161932),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(31.50),
                    ),
                  ),
                  // width: screenWidth * 0.9,
                  // height: screenHeight * 0.8,
                  // padding: EdgeInsets.symmetric(
                  //   horizontal: screenWidth * 0.06,
                  //   vertical: screenHeight * 0.04,
                  // ),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // width: screenWidth * 0.87,
                        // height: screenHeight * 0.08,
                        // decoration: ShapeDecoration(
                        //   color: AppColors.overlayDark,
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius:
                        //         BorderRadius.circular(screenHeight * 0.04),
                        //   ),
                        // ),

                        decoration: ShapeDecoration(
                          color: Color(0xFF161932),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(31.50),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(tabTitles.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                ref.read(selectedTabProvider.notifier).state =
                                    index;
                              },
                              child: Container(
                                width: screenWidth * 0.28,
                                height: screenHeight * 0.06,
                                decoration: ShapeDecoration(
                                  color: selectedTab == index
                                      ? AppColors.primaryRed
                                      : Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        screenHeight * 0.04), //26.5
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                //alignment: Alignment.center,
                                child: Text(
                                  tabTitles[index],
                                  style: TextStyle(
                                    color: selectedTab == index
                                        ? AppColors.textDark
                                        : AppColors.textFill.withOpacity(0.4),
                                    fontSize: 12,
                                    fontFamily: 'Kumbh Sans',
                                    fontWeight: FontWeight.w700,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 57), //screenHeight * 0.07
                //may try expanded
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
                          width: constraints.maxWidth * 0.8,
                          height: constraints.maxWidth * 0.8,
                          child: Stack(
                            children: [
                              Container(
                                decoration: ShapeDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment(-0.71, 0.71),
                                    end: Alignment(0.71, -0.71),
                                    colors: [
                                      Color(0xFF2D325A),
                                      Color(0xFF0E1029)
                                    ],
                                  ),
                                  shape: OvalBorder(),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0xFF12152F),
                                      blurRadius: constraints.maxWidth * 0.266,
                                      offset: Offset(
                                          constraints.maxWidth * 0.133,
                                          constraints.maxWidth * 0.133),
                                    ),
                                    BoxShadow(
                                      color: Color(0xFF272C5A),
                                      blurRadius: constraints.maxWidth * 0.266,
                                      offset: Offset(
                                          -constraints.maxWidth * 0.133,
                                          -constraints.maxWidth * 0.133),
                                    )
                                  ],
                                ),
                              ),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      time.timeLeft,
                                      style: TextStyle(
                                        color: Color(0xFFD6E0FE),
                                        fontSize: constraints.maxWidth * 0.2,
                                        fontFamily: 'Kumbh Sans',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      buttonText[time.buttonState]!,
                                      style: TextStyle(
                                        color: Color(0xFFD7E0FF),
                                        fontSize: 14,
                                        fontFamily: 'Kumbh Sans',
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
                const SizedBox(height: 57),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: IconButton(
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) {
                          return SettingsScreen();
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
