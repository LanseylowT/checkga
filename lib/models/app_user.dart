enum UserRole {
  admin,
  staff,
  guest,
}

class AppUser {
  final String uid;
  late final String email;
  late final String? firstName;
  late final String? lastName;
  final String yearLevel;
  final UserRole role;

  UserRole _stringToUserRole(String? role) {
    return UserRole.values.firstWhere(
        (role) => role.toString().split('.').last == role,
        orElse: () => UserRole.guest);
  }

  AppUser({
    this.firstName,
    this.lastName,
    required this.email,
    required this.uid,
    required this.role,
    required this.yearLevel,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'uid': uid,
      'email': email,
      'yearLevel': yearLevel,
      'role': role.toString().split('.').last
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      email: map['email'],
      uid: map['uid'],
      role: UserRole.values.firstWhere(
          (role) => role.toString().split('.').last == map['role'],
          orElse: () => UserRole.guest),
      yearLevel: map['yearLevel'],
      firstName: map['firstName'],
      lastName: map['lastName'],
    );
  }
}
