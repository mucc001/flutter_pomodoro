import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro/models/timer_model.dart';
import 'package:pomodoro/providers/timer_provider.dart';

void main() {
  test('Initial state of TimerNotifier should be initial with correct duration',
      () {
    final container = ProviderContainer(
      overrides: [
        pomodoroInitProvider.overrideWith((ref) => 25),
      ],
    );

    final timerModel = container.read(pomoTimerProvider);

    expect(timerModel.timeLeft, '25:00');
    expect(timerModel.buttonState, ButtonState.initial);
  });

  test('TimerNotifier should start and decrement correctly', () async {
    final container = ProviderContainer(
      overrides: [
        pomodoroInitProvider.overrideWith((ref) => 1),
      ],
    );

    final timerNotifier = container.read(pomoTimerProvider.notifier);

    timerNotifier.start();

    await Future.delayed(Duration(seconds: 1));

    expect(container.read(pomoTimerProvider).timeLeft, '00:59');
    expect(container.read(pomoTimerProvider).buttonState, ButtonState.started);
  });

  test('TimerNotifier should pause and resume correctly', () async {
    final container = ProviderContainer(
      overrides: [
        pomodoroInitProvider.overrideWith((ref) => 1),
      ],
    );

    final timerNotifier = container.read(pomoTimerProvider.notifier);

    timerNotifier.start();

    await Future.delayed(Duration(seconds: 10));

    timerNotifier.pause();

    final pausedTimeLeft = container.read(pomoTimerProvider).timeLeft;
    expect(container.read(pomoTimerProvider).buttonState, ButtonState.paused);

    await Future.delayed(Duration(seconds: 5));

    // Time should not have decreased since the timer is paused
    expect(container.read(pomoTimerProvider).timeLeft, pausedTimeLeft);

    timerNotifier.start();

    await Future.delayed(Duration(seconds: 1));

    expect(container.read(pomoTimerProvider).timeLeft != pausedTimeLeft, true);
    expect(container.read(pomoTimerProvider).buttonState, ButtonState.started);
  });

  test('TimerNotifier should reset correctly', () async {
    final container = ProviderContainer(
      overrides: [
        pomodoroInitProvider.overrideWith((ref) => 1),
      ],
    );

    final timerNotifier = container.read(pomoTimerProvider.notifier);

    timerNotifier.start();

    await Future.delayed(Duration(seconds: 10));

    timerNotifier.reset();

    expect(container.read(pomoTimerProvider).timeLeft, '01:00');
    expect(container.read(pomoTimerProvider).buttonState, ButtonState.initial);
  });

  test('TimerNotifier should transition to finished state after completion',
      () async {
    final container = ProviderContainer(
      overrides: [
        pomodoroInitProvider.overrideWith((ref) => 1),
      ],
    );

    final timerNotifier = container.read(pomoTimerProvider.notifier);

    timerNotifier.start();

    await Future.delayed(Duration(seconds: 60));

    expect(container.read(pomoTimerProvider).timeLeft, '00:00');
    expect(container.read(pomoTimerProvider).buttonState, ButtonState.finished);
  });

  test(
      'TimerNotifier should immediately finish when started with zero duration',
      () {
    final container = ProviderContainer(
      overrides: [
        pomodoroInitProvider.overrideWith((ref) => 0),
      ],
    );

    final timerNotifier = container.read(pomoTimerProvider.notifier);

    timerNotifier.start();

    expect(container.read(pomoTimerProvider).timeLeft, '00:00');
    expect(container.read(pomoTimerProvider).buttonState, ButtonState.finished);
  });

  test('TimerNotifier should reset correctly during active timer', () async {
    final container = ProviderContainer(
      overrides: [
        pomodoroInitProvider.overrideWith((ref) => 1),
      ],
    );

    final timerNotifier = container.read(pomoTimerProvider.notifier);

    timerNotifier.start();

    await Future.delayed(Duration(seconds: 30));

    timerNotifier.reset();

    expect(container.read(pomoTimerProvider).timeLeft, '01:00');
    expect(container.read(pomoTimerProvider).buttonState, ButtonState.initial);
  });

  test(
      'Switching between timers should reset previous timer and initialize new one',
      () async {
    final container = ProviderContainer();

    final pomoTimerNotifier = container.read(pomoTimerProvider.notifier);
    final shortBreakNotifier = container.read(shortTimerProvider.notifier);

    pomoTimerNotifier.start();
    await Future.delayed(Duration(seconds: 10));

    shortBreakNotifier.start();

    // Pomodoro timer should reset
    expect(container.read(pomoTimerProvider).timeLeft, '20:00');
    expect(container.read(pomoTimerProvider).buttonState, ButtonState.initial);

    // Short break timer should start
    expect(container.read(shortTimerProvider).buttonState, ButtonState.started);
  });

  test('Manual time adjustment should be reflected in the timer', () {
    final container = ProviderContainer(
      overrides: [
        tempPomodoroInitProvider.overrideWith((ref) => 30),
      ],
    );

    final timerNotifier = container.read(pomoTimerProvider.notifier);

    timerNotifier.reset();

    expect(container.read(pomoTimerProvider).timeLeft, '30:00');
    expect(container.read(pomoTimerProvider).buttonState, ButtonState.initial);
  });
}
