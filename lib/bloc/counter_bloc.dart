import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_exmaple/bloc/counter_states.dart';

class CounterBloc extends Cubit<CounterStates> {
  CounterBloc() : super(const changedCounter(0)); // Fixed: Uppercase and const

  void incrementCounter() {
    if (state is changedCounter) {
      final currentState = state as changedCounter;
      emit(changedCounter(currentState.counter + 1));
    }
  }

  void decrementCounter() {
    if (state is changedCounter) {
      final currentState = state as changedCounter;
      emit(changedCounter(currentState.counter - 1));
    }
  }
}