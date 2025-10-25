import 'package:equatable/equatable.dart';

abstract class CounterStates extends Equatable {
  const CounterStates();

  @override
  List<Object> get props => [];
}

class InitialCounter extends CounterStates {
  const InitialCounter();
}

class changedCounter extends CounterStates {
  final int counter;
  const changedCounter(this.counter);

  @override
  List<Object> get props => [counter];
}