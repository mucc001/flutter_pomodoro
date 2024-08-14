import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pomodoro/models/timer_model.dart';

final pomodoroInitProvider = StateProvider<int>((ref) => 20);
final longBreakInitProvider = StateProvider<int>((ref) => 15);
final shortBreakInitProvider = StateProvider<int>((ref) => 5);

final tempPomodoroInitProvider = StateProvider<int>((ref) => 20);
final tempLongBreakInitProvider = StateProvider<int>((ref) => 15);
final tempShortBreakInitProvider = StateProvider<int>((ref) => 5);

final pomoTimerProvider = StateNotifierProvider<TimerNotifier, TimerModel>(
  (ref) {
    return TimerNotifier(ref, pomodoroInitProvider);
  },
);

final longTimerProvider = StateNotifierProvider<TimerNotifier, TimerModel>(
  (ref) {
    return TimerNotifier(ref, longBreakInitProvider);
  },
);

final shortTimerProvider = StateNotifierProvider<TimerNotifier, TimerModel>(
  (ref) {
    return TimerNotifier(ref, shortBreakInitProvider);
  },
);

class TimerNotifier extends StateNotifier<TimerModel> {
  TimerNotifier(this.ref, this.initDurationProvider)
      : super(TimerModel(_durationString(ref.read(initDurationProvider)),
            ButtonState.initial)) {
    _initialize();
  }

  final Ref ref;
  final StateProvider<int> initDurationProvider;

  final Ticker _ticker = Ticker();
  StreamSubscription<int>? _tickerSubscription;

  void _initialize() {
    final int sessionDuration = ref.read(initDurationProvider);
    state = TimerModel(
      _durationString(sessionDuration),
      ButtonState.initial,
    );
  }

  static String _durationString(int duration) {
    final minutes = (duration ~/ 60).toString().padLeft(2, '0');
    final seconds = (duration % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void start() {
    if (state.buttonState == ButtonState.paused) {
      _resumeTimer();
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    final int sessionDuration = ref.watch(initDurationProvider);

    _tickerSubscription?.cancel();

    _tickerSubscription =
        _ticker.tick(ticks: sessionDuration).listen((duration) {
      state = TimerModel(_durationString(duration), ButtonState.started);
    });

    _tickerSubscription?.onDone(() {
      state = TimerModel(state.timeLeft, ButtonState.finished);
    });

    state = TimerModel(_durationString(sessionDuration), ButtonState.started);
  }

  void _resumeTimer() {
    _tickerSubscription?.resume();
    state = TimerModel(state.timeLeft, ButtonState.started);
  }

  void pause() {
    _tickerSubscription?.pause();
    state = TimerModel(state.timeLeft, ButtonState.paused);
  }

  void reset() {
    _tickerSubscription?.cancel();
    _initialize();
  }

  @override
  void dispose() {
    _tickerSubscription?.cancel();
    super.dispose();
  }
}

class Ticker {
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(
      const Duration(seconds: 1),
      (x) => ticks - x - 1,
    ).take(ticks);
  }
}
