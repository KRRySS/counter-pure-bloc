# counter-pure-bloc
Very simple example of BLoC architecture pattern without Flutter BLoC dependencies like flutter_bloc (in the result with many boilerplate code) on popular Counter initial app. 
I use StreamBuilder, StreamController, Stream and Sink for preparing sample BLoC abstraction and show how it can works "under the hood" without popular libraries:
- stream management for events,
- stream management for counter,
- adding new evnets to sink,
- mapping events to state,
- returning widgets and capturing snapshots of received stream data,
- closing all stream for preventing memory leaks,
