
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data_base.dart';

/// Event being processed by [CounterBloc].
abstract class CounterEvent {}

/// Notifies bloc to increment state.
class CounterIncrementPressed extends CounterEvent {

}

/// Notifies bloc to decrement state.
class CounterDecrementPressed extends CounterEvent {
  final int cc;
  CounterDecrementPressed({required this.cc});

}

/// {@template counter_bloc}
/// A simple [Bloc] that manages an `int` as its state.
/// {@endtemplate}
class CounterBloc extends Bloc<CounterEvent, int> {
  final int co;
  /// {@macro counter_bloc}
  CounterBloc({required this.co}) : super(0) {
    on<CounterIncrementPressed>((event, emit) async {
      final xx = await DataUserBasket.countBasket();
      emit(xx);
    },);
    on<CounterDecrementPressed>((event, emit) => emit(event.cc));
  }
}