import 'package:checkga/models/event.dart';
import 'package:checkga/repositories/event_repository.dart';
import 'package:flutter/material.dart';

class EventViewmodel extends ChangeNotifier {
  final EventRepository _repository = EventRepository();
  List<Event> _events = [];

  List<Event> get events => _events;

  void fetchEvents() {
    _repository.getEvents().listen((eventsList) {
      _events = eventsList;
      notifyListeners();
    });
  }
}
