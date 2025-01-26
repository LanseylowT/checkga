import 'package:checkga/models/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventRepository {
  final CollectionReference events =
      FirebaseFirestore.instance.collection('events');

  Future<void> addEvent(Event event) async {
    await events.doc(event.eventName).set(event.toMap());
  }

  Future<void> updateEvent(Event event) async {
    await events.doc(event.eventName).update(event.toMap());
  }

  Future<void> deleteEvent(String eventName) async {
    await events.doc(eventName).delete();
  }

  Future<List<Event>> getOpenEvents() async {
    final querySnapshot = await events.where('isOpen', isEqualTo: true).get();
    return querySnapshot.docs
        .map((doc) => Event.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Stream<List<Event>> getEvents() {
    return events.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Event.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }
}
