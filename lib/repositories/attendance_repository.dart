import 'package:checkga/models/attendance_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceRepository {
  final CollectionReference attendance =
      FirebaseFirestore.instance.collection('attendance-item');

  Future<void> addAttendance(AttendanceItem item) async {
    await attendance.add(item.toMap());
  }

  Future<List<AttendanceItem>> getAttendanceByStudent(String studentId) async {
    final querySnapshot =
        await attendance.where('studentId', isEqualTo: studentId).get();
    return querySnapshot.docs
        .map(
            (doc) => AttendanceItem.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Stream<List<AttendanceItem>> getAttendance() {
    return attendance.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              AttendanceItem.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }
}
