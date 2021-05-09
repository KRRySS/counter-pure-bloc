import 'dart:async';

import 'package:counter_pure_bloc/presentation/bloc/counter_event.dart';

class CounterBloc {
  // stream management for events
  final _eventController = StreamController<CounterEvent>();
  Stream<CounterEvent> get eventStream => _eventController.stream;
  Sink<CounterEvent> get eventSink => _eventController.sink;

  //stream management for counter
  final _counterController = StreamController<int>();
  Stream<int> get counter => _counterController.stream;
  StreamSink<int> get _inCounter => _counterController.sink;

  //initial value for counter
  int _counter = 0;

  CounterBloc() {
    eventStream.listen(_mapEventToState);
  }

  void _mapEventToState(event) {
    //this callback will be called after added new event from sink
    if (event is IncrementEvent)
      ++_counter;
    else if (event is DecrementEvent) --_counter;
    _inCounter.add(_counter);
  }

  //close all streams
  dispose() {
    _eventController.close();
    _counterController.close();
  }
}
