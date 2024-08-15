enum ButtonState { initial, paused, started, finished }

class TimerModel {
  const TimerModel(this.timeLeft, this.buttonState, this.duration);
  final String timeLeft;
  final ButtonState? buttonState;
  final int duration;
}
