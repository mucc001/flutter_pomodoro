enum ButtonState { initial, paused, started, finished }

class TimerModel {
  const TimerModel(this.timeLeft, this.buttonState);
  final String timeLeft;
  final ButtonState? buttonState;
}
