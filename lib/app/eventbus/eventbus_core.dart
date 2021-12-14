import 'dart:async';

import 'package:mymoneyorganizer/app/eventbus/events/base/base_event.dart';

class EventBusCore {
  static EventBusCore? _instance;
  final StreamController<BaseEvent> _streamController = StreamController.broadcast();

  EventBusCore._();

  factory EventBusCore.getInstance() {
    _instance ??= EventBusCore._();
    return _instance!;
  }

  Stream<BaseEvent> get events {
    return _streamController.stream;
  }

  void addEvent(BaseEvent event) {
    _streamController.add(event);
  }

  dispose() {
    _streamController.close();
  }
}
