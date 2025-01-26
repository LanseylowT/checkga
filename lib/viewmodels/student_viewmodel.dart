import 'package:checkga/models/student.dart';
import 'package:checkga/repositories/student_repository.dart';
import 'package:flutter/material.dart';

class StudentViewmodel extends ChangeNotifier {
  final StudentRepository _repository = StudentRepository();
  List<Student> _students = [];

  List<Student> get students => _students;

  void fetchStudents() {
    _repository.getStudents().listen((studentList) {
      _students = studentList;
      notifyListeners();
    });
  }

  Stream<List<Student>> getStudentsStream() {
    return _repository.getStudents();
  }
}
