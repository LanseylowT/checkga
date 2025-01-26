import 'package:checkga/models/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentRepository {
  final CollectionReference students =
      FirebaseFirestore.instance.collection('student-info');

  Future<void> addStudent(Student student) async {
    await students.doc(student.studentId).set(student.toMap());
  }

  Future<void> updateStudent(Student student) async {
    await students.doc(student.studentId).update(student.toMap());
  }

  Future<void> deleteStudent(String studentId) async {
    await students.doc(studentId).delete();
  }

  Future<Student?> getStudentById(String studentId) async {
    final doc = await students.doc(studentId).get();

    if (doc.exists) {
      return Student.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<List<Student>> getStudentsByYearLevel(String yearLevel) async {
    final querySnapshot =
        await students.where('yearLevel', isEqualTo: yearLevel).get();
    return querySnapshot.docs
        .map((doc) => Student.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Stream<List<Student>> getStudents() {
    return students.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Student.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }
}
