part of 'switch_bloc.dart';

abstract class SwitchEvent {
  SwitchEvent();
}

class EnableOrDisableNotification extends SwitchEvent {}

class SliderEvent extends SwitchEvent {
  double slider;
  SliderEvent({required this.slider});
}
