import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro/models/timer_model.dart';
import 'package:pomodoro/providers/timer_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
// Import your actual provider and notifier files here

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Timer Provider and Notifier Tests', () {
    late ProviderContainer container;

    ProviderContainer createContainer({
      List<Override> overrides = const [],
    }) {
      final container = ProviderContainer(overrides: overrides);
      addTearDown(container.dispose);
      return container;
    }

    setUp(() {
      container = createContainer();
    });

    test('1. Initial state is correct', () {
      final initialState = container.read(timerProvider);
      expect(initialState.timeLeft, '25:00');
      expect(initialState.buttonState, ButtonState.initial);
    });

    test('2. sessionDurationProvider initializes with default value', () {
      expect(container.read(sessionDurationProvider), 25);
    });

    test('3. Updating sessionDurationProvider affects timer', () {
      container.read(sessionDurationProvider.notifier).state = 30;
      final timerState = container.read(timerProvider);
      expect(timerState.timeLeft, '30:00');
    });

    test('4. Timer start changes button state', () {
      final notifier = container.read(timerProvider.notifier);
      notifier.start();
      expect(container.read(timerProvider).buttonState, ButtonState.started);
    });

    test('5. Timer pause changes button state', () {
      final notifier = container.read(timerProvider.notifier);
      notifier.start();
      notifier.pause();
      expect(container.read(timerProvider).buttonState, ButtonState.paused);
    });

    test('6. Timer resume from paused state', () {
      final notifier = container.read(timerProvider.notifier);
      notifier.start();
      notifier.pause();
      notifier.start();
      expect(container.read(timerProvider).buttonState, ButtonState.started);
    });

    test('7. Timer reset returns to initial state', () {
      final notifier = container.read(timerProvider.notifier);
      notifier.start();
      notifier.reset();
      final state = container.read(timerProvider);
      expect(state.buttonState, ButtonState.initial);
      expect(state.timeLeft, '25:00');
    });

    test('8. Timer completes correctly', () async {
      container = createContainer(
          overrides: [sessionDurationProvider.overrideWith((ref) => 2)]);
      final listener = Listener<TimerModel>();
      container.listen(timerProvider, listener, fireImmediately: true);

      container.read(timerProvider.notifier).start();

      await Future.delayed(Duration(seconds: 3));

      verify(() => listener(
          any(),
          any(
              that: predicate((TimerModel state) =>
                  state.buttonState == ButtonState.finished &&
                  state.timeLeft == '00:00')))).called(1);
    });

    test('9. Time display format is correct', () {
      container = createContainer(
          overrides: [sessionDurationProvider.overrideWith((ref) => 61)]);
      expect(container.read(timerProvider).timeLeft, '01:01');
    });

    test('10. Timer with short duration', () async {
      container = createContainer(
          overrides: [sessionDurationProvider.overrideWith((ref) => 1)]);
      final listener = Listener<TimerModel>();
      container.listen(timerProvider, listener, fireImmediately: true);

      container.read(timerProvider.notifier).start();

      await Future.delayed(Duration(seconds: 2));

      verify(() => listener(
          any(),
          any(
              that: predicate((TimerModel state) =>
                  state.buttonState == ButtonState.finished &&
                  state.timeLeft == '00:00')))).called(1);
    });

    test('11. Concurrent operations: start then immediately pause', () {
      final notifier = container.read(timerProvider.notifier);
      notifier.start();
      notifier.pause();
      expect(container.read(timerProvider).buttonState, ButtonState.paused);
    });

    test('12. Concurrent operations: start then immediately reset', () {
      final notifier = container.read(timerProvider.notifier);
      notifier.start();
      notifier.reset();
      final state = container.read(timerProvider);
      expect(state.buttonState, ButtonState.initial);
      expect(state.timeLeft, '25:00');
    });

    test('13. Ticker emits correct values', () async {
      final ticker = Ticker();
      final stream = ticker.tick(ticks: 5);
      expect(
        stream,
        emitsInOrder([4, 3, 2, 1, 0]),
      );
    });

    test('14. Multiple start/pause/resume cycles', () {
      final notifier = container.read(timerProvider.notifier);
      notifier.start();
      notifier.pause();
      notifier.start();
      notifier.pause();
      notifier.start();
      expect(container.read(timerProvider).buttonState, ButtonState.started);
    });

    test('15. Timer behavior over longer period', () async {
      container = createContainer(
          overrides: [sessionDurationProvider.overrideWith((ref) => 10)]);
      final listener = Listener<TimerModel>();
      container.listen(timerProvider, listener, fireImmediately: true);

      container.read(timerProvider.notifier).start();

      await Future.delayed(Duration(seconds: 5));

      verify(() => listener(
          any(),
          any(
              that: predicate(
                  (TimerModel state) => state.timeLeft == '00:05')))).called(1);
    });

    // Note: Disposal test is implicitly handled by createContainer function
  });
}

// Mock class for the listener
class Listener<T> extends Mock {
  void call(T? previous, T next);
}
