import 'package:intl/intl.dart';

class Event {
  String eventName;
  DateTime date;
  bool isOpen = false;
  String organizer;
  String venue;

  Event({
    required this.eventName,
    required this.date,
    required this.isOpen,
    required this.organizer,
    required this.venue,
  });

  Map<String, dynamic> toMap() {
    return {
      'eventName': eventName,
      'date': date,
      'isOpen': isOpen,
      'organizer': organizer,
      'venue': venue,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      eventName: map['eventName'] ?? '',
      date: DateTime.parse(map['date']),
      isOpen: map['isOpen'] ?? '',
      organizer: map['organizer'] ?? '',
      venue: map['venue'] ?? '',
    );
  }

  getFormatedDateTimeString() {
    return DateFormat('MMMM d, yyyy, h:mm a')
        .format(date); // Formats date like 'December 10, 2024'
  }

  getFormatedDateString() {
    return DateFormat('MMMM d, yyyy')
        .format(date); // Formats date like 'December 10, 2024'
  }

  getFormatedTimeString() {
    return DateFormat('h:mm a')
        .format(date); // Formats date like 'December 10, 2024'
  }
}
