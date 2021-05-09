## Architecture overview
Very simple example of BLoC architecture pattern without Flutter BLoC dependencies like [flutter_bloc](https://pub.dev/packages/flutter_bloc) (in the result with many boilerplate code) on popular Counter initial app.
I use [StreamBuilder](https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html), [StreamController](https://api.flutter.dev/flutter/dart-async/StreamController-class.html), [Stream](https://api.flutter.dev/flutter/dart-async/Stream-class.html) and [Sink](https://api.flutter.dev/flutter/dart-core/Sink-class.html) to preparing sample BLoC abstraction and showing how it can works "under the hood" without popular libraries:
- stream management for events:
```dart
  final _eventController = StreamController<CounterEvent>();
  Stream<CounterEvent> get eventStream => _eventController.stream;
  Sink<CounterEvent> get eventSink => _eventController.sink;

```
- stream management for counter:
```dart
  final _counterController = StreamController<int>();
  Stream<int> get counter => _counterController.stream;
  StreamSink<int> get _inCounter => _counterController.sink;

```
- adding new evnets to sink:
```dart
  _counterBloc.eventSink.add(IncrementEvent());

```
- mapping events to state:
```dart
  CounterBloc() {
    eventStream.listen(_mapEventToState);
  }

  void _mapEventToState(event) {
    if (event is IncrementEvent)
      ++_counter;
    else if (event is DecrementEvent) --_counter;
    _inCounter.add(_counter);
  }

```
- returning widgets and capturing snapshots of received stream data:
```dart
  StreamBuilder<int>(
    stream: _counterBloc.counter,
    initialData: 0,
    builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
      final counter = snapshot.data;
      return Text(
        '$counter',
        style: Theme.of(context).textTheme.headline4,
      );
    },
  ),

```
- closing all stream for preventing memory leaks:
```dart
  dispose() {
    _eventController.close();
    _counterController.close();
  }

```


<br />
<br />

![alt text][architecture]

[architecture]: https://koenig-media.raywenderlich.com/uploads/2020/08/04-BLoC-diagram-1.png "BLoC pattern, resource: https://www.raywenderlich.com/4074597-getting-started-with-the-bloc-pattern"
