class Student {
  final String firstName;
  final String lastName;
  final String studentId;
  final String yearLevel;

  Student({
    required this.firstName,
    required this.lastName,
    required this.studentId,
    required this.yearLevel,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'studentId': studentId,
      'yearLevel': yearLevel,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      firstName: map['firstName'],
      lastName: map['lastName'],
      studentId: map['studentId'],
      yearLevel: map['yearLevel'],
    );
  }
}
