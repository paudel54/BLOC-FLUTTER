import 'package:equatable/equatable.dart';

class CounterState extends Equatable {
  final int counter;
  const CounterState({this.counter = 0});

  CounterState copyWith({int? newCounterValue}) {
    return CounterState(
      // ignore: unnecessary_this
      counter: newCounterValue ?? counter,
    );
  }

  @override
  List<Object?> get props => [counter];
}
