import 'package:checkga/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserRole> fetchUserRole(String uid) async {
    final adminDoc = await _firestore.collection('admin').doc(uid).get();
    if (adminDoc.exists) return UserRole.admin;

    final staffDoc = await _firestore.collection('staff').doc(uid).get();
    if (staffDoc.exists) return UserRole.staff;

    return UserRole.guest;
  }

  Future<UserCredential> signInWithEmail(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
