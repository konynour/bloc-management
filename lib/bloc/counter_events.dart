import 'package:equatable/equatable.dart';

abstract class CounterEvents extends Equatable {
  const CounterEvents();

  @override
  List<Object> get props => [];
}


class Increment extends CounterEvents{}
class Decrement extends CounterEvents{}
