import 'package:checkga/models/attendance_item.dart';
import 'package:checkga/repositories/attendance_repository.dart';
import 'package:flutter/material.dart';

class AttendanceViewmodel extends ChangeNotifier {
  final AttendanceRepository _repository = AttendanceRepository();
  List<AttendanceItem> _attendance = [];

  List<AttendanceItem> get attendance => _attendance;

  void fetchAttendance() {
    _repository.getAttendance().listen((attendanceList) {
      _attendance = attendanceList;
      notifyListeners();
    });
  }
}
