import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceItem {
  final DocumentReference event;
  final bool isPresent;
  final DocumentReference student;
  final String studentId;

  AttendanceItem({
    required this.event,
    required this.isPresent,
    required this.student,
    required this.studentId,
  });

  Map<String, dynamic> toMap() {
    return {
      'event': event,
      'isPresent': isPresent,
      'student': student,
      'studentId': studentId,
    };
  }

  factory AttendanceItem.fromMap(Map<String, dynamic> map) {
    return AttendanceItem(
      event: map['event'] as DocumentReference,
      isPresent: map['isPresent'] ?? false,
      student: map['student'] as DocumentReference,
      studentId: map['studentId'] ?? '',
    );
  }
}
